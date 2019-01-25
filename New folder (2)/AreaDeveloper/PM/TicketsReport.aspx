<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TicketsReport.aspx.vb" Inherits="PM_TicketsReport" Theme="Default"  %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Ticket Report</title>
     <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
     <style type="text/css">
            .tblDeliverable{border-left:1px solid black;border-top:1px solid black;}
		.tblDeliverable td{border-right-color:black;border-bottom-color:black;}
    </style>
</head>
<body style="height:100%; width:100%; text-align:center;">
    <form id="form1" runat="server">
   <div style="height:100%; width:100%;" align="center">
    <asp:HiddenField id="hdnTicketID" runat="server" EnableViewState="False"></asp:HiddenField>
    <asp:HiddenField ID="hdnTimeSpent" runat="server" Value="00:00:00" EnableViewState="False" />
        <table  cellpadding="0" cellspacing="0" style="height:100%; width:650; text-align:left; border:5px double #EFEFEF; font-size:10pt;padding-right: 10px; padding-left: 10px;">
            <tr>
                <td colspan="5" valign="top">
                    <table align="center" border="0" cellpadding="2" cellspacing="4" width="640">
                        <tr>
                            <td align="center" class="CompanyLogo" valign="top">
                               <img src="../../images/logo_netsolace_btm.gif" </td>
                        </tr>
                        <tr>
                            <td align="center" class="CompanyName" valign="top">
                                Mynetsolace Project Management</td>
                        </tr>
                        <tr>
                            <td align="center" class="CompanyName">
                                <span id="tdTitleReport" runat="server">Ticket Report</span></td>
                        </tr>
                    </table>                    
                </td>
            </tr>
             <tr><td style="padding-bottom:5px;" colspan="5">
                <table cellpadding="0" cellspacing="0" style="font-size:11px;border-bottom: 1px solid #000000;" width="100%">
             <tr>
                <td style="width:120px;"><asp:Label ID="lblTicketColumnName" runat="server" EnableViewState="False"></asp:Label></td>
                <td><asp:Label ID="lblTicketNo" runat="server" EnableViewState="False"></asp:Label></td>                
            </tr>
            <tr>
                <td>Type:</td>
                <td><asp:Label ID="lblType" runat="server" EnableViewState="False"></asp:Label></td>
            </tr>
            <tr>
                <td>Subject: </td>
                <td><asp:Label ID="lblTicketName" runat="server" EnableViewState="False"></asp:Label></td>                
            </tr>
            <tr>
                <td>Priority:</td>
                <td><asp:Label ID="lblPriority" runat="server" EnableViewState="False"></asp:Label></td>
            </tr>
            <tr>
                <td>Client:</td>
                <td><asp:Label ID="lblClient" runat="server" EnableViewState="False"></asp:Label></td>
            </tr>
            <tr>
                <td>Category:</td>
                <td><asp:Label ID="lblCategory" runat="server"  EnableViewState="False"></asp:Label></td>
            </tr>
            <tr>
                <td>Due Date:</td>
                <td><asp:Label ID="lblDueDate" runat="server" EnableViewState="False"></asp:Label></td>                
            </tr>
            <tr>
                <td><span id="tdrelease" runat="server" >Release:</span></td>
                <td><asp:Label ID="lblReleaseName" runat="server" EnableViewState="False"></asp:Label></td>
            </tr>
            <tr>
                <td>Created By:</td>
                <td><asp:Label ID="lblUserID" runat="server" EnableViewState="False"></asp:Label></td>
            </tr>
            <tr>
                <td>Date Created:</td>
                <td><asp:Label ID="lblDateEntered" runat="server" EnableViewState="False"></asp:Label></td>
            </tr>
            <tr>
                <td>Required Date:</td>
                <td><asp:Label ID="lblRequiredDate" runat="server" EnableViewState="False"></asp:Label></td>                
            </tr>  
                </table>
            </td></tr>  
            <tr>
                <td colspan="5" align="center" style="padding-right: 10px; padding-left: 10px">
                     <asp:Repeater ID="rptrNotes" runat="server" DataSourceID="sdsNotes"  EnableViewState="false">
                                <HeaderTemplate>
                                    <table width="100%" border="0" style="font-size:10px;" cellspacing="0" class="Table"  cellpadding="0" >                                                   
                                </HeaderTemplate>
                                <ItemTemplate>
                                  <tr valign="top" style=" height:20px;" >
                                    <td align="left" style="border-left:0px;border-bottom:1px solid #000000; border-bottom-style:solid; font-size:11px;"   >
                                     <br /> 
                                    <asp:Label ID="lblID" runat="Server" Visible="false" Text='<%#Container.DataItem("ID")%>' ></asp:Label><asp:Label ID="lblTimeSpent" runat="Server" Visible="false" Text='<%#Container.DataItem("TimeSpent")%>' ></asp:Label><asp:Label ID="lblUserName" runat="Server" style="font-size:11px; font-weight:bold;" Text='<%#IIf(Functions.IfNull(Container.DataItem("UserID"), 0) <> 0, Functions.IfNull(Container.DataItem("UserName"), ""), Functions.IfNull(Container.DataItem("ClientContactName"), ""))%>'></asp:Label> On: <asp:Label ID="lblDateEntered" runat="Server" style="font-size:8pt; font-weight:bold;" Text='<%#Container.DataItem("DateEntered")%>'></asp:Label>
                                    <asp:Repeater ID="rptrAttachments" runat="server"  EnableViewState="false">
                                            <HeaderTemplate >
                                                <span style="font-style:italic;"><br />Attachments:</span>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                [&nbsp;<%#Container.DataItem("FileName")%>&nbsp;] &nbsp;
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    <br />                                                     
                                       <%#CType(Container.DataItem("Notes"), String).Replace(vbCrLf, "<br />")%> 
                                        <br />
                                        <br />                                                                    
                                    </td>                                    
                                  </tr>                  
                                </ItemTemplate>
                                <FooterTemplate>               
                               </table>
                             </FooterTemplate>
                            </asp:Repeater> 
                            <asp:Repeater ID="rptrTicket" runat="server" DataSourceID="sdsActivity"  >
                              <ItemTemplate>  
                                <table  cellpadding="0" cellspacing="0"  border="0" width="100%"  >
                                     <tr>
                                            <td>
                                                 <table cellpadding="2" cellspacing="0" border="0" width="100%" style="font-size:11px;">
                                                  
                                                    <tr>   
                                                            <br />                                                                                      
                                                            <td style=" font-size:11px; width:80%; font-weight:bold;" >Original message sent by <%#IIf(Functions.IfNull(Container.DataItem("UserID"), 0) <> 0, Functions.IfNull(Container.DataItem("UserName"), ""), Functions.IfNull(Container.DataItem("ClientContactName"), ""))%> on <%#Container.DataItem("DateEntered")%></td>
                                                            <td style=" width:10%;" align="right"> </td>  
                                                            <td style="width:5%;">  </td>                           
                                                    </tr>
                                                    
                                                    <tr>
                                                        <td colspan="3">
                                                        
                                                        <asp:Repeater ID="rptrTicketAttachments" runat="server"  EnableViewState="false" DataSourceID="SDS_TicketsAttachments" >
                                                            <HeaderTemplate >
                                                                <span style="font-style:italic;">Attachments:</span>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                               [&nbsp;<%#Container.DataItem("FileName")%>&nbsp;] &nbsp;
                                                            </ItemTemplate>
                                                        </asp:Repeater>
                                                        </td>
                                                    </tr>
                                                                                       
                                                    <tr>                                                                                 
                                                            <td colspan="3"  style="font-size:11px; ">
                                                                  <%#CType(Container.DataItem("Description"),String).Replace(vbCrLf,"<br />")%> 
                                                                  <br />
                                                                  <br />             
                                                            </td>
                                                            <td>
                                                            </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="4" style="border-top:1px solid #000000; border-top-style:solid; " >
                                                        &nbsp;
                                                        </td>
                                                    </tr>      
                                                </table>                                 
                                            </td>
                                        </tr>
                                </table>
                            </ItemTemplate>
                     </asp:Repeater>  
                </td>
            </tr>            
            <tr>
                <td colspan="2" style="padding-left: 11px; font-style:italic;">
                    <asp:label ID="lblPrintDate" runat="server"  Font-Size="8pt" EnableViewState="False"></asp:label></td>
                <td colspan="3">
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
            </tr>
        </table>
        <asp:SqlDataSource ID="sdsActivity" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                        SelectCommand="PM_GetTicket_Feature_DetailByID" 
                        SelectCommandType="StoredProcedure" EnableViewState="False">                      
                        <SelectParameters>
                            <asp:ControlParameter ControlID="hdnTicketID" DefaultValue="0" Name="TicketID" PropertyName="Value"
                                Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="SDS_TicketsAttachments" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                        SelectCommand="PM_Ticket_Features_Attachments_GetByTicketID" 
                        SelectCommandType="StoredProcedure" EnableViewState="False">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="hdnTicketID" Name="Ticket_FeatureID" PropertyName="Value"
                                Type="Int32" DefaultValue="0" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource 
                       ID="sdsNotes" 
                       runat="server" 
                       ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"                                                        
                       SelectCommand="PM_Notes_GetByTicketIDForMyNetsolace" 
                       SelectCommandType="StoredProcedure"
                       DataSourceMode="DataSet" EnableViewState="False" >
                       <SelectParameters >
                         <asp:ControlParameter Name="TicketID" DefaultValue="0"  ControlID="hdnTicketID" Type="Int32" PropertyName="value" />
                       </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="sdsAttachments" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                        SelectCommand="PM_Attachments_GetByTicketID" 
                        SelectCommandType="StoredProcedure" EnableViewState="False">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="hdnTicketID" DefaultValue="0" Name="TicketID" PropertyName="value"
                                Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>