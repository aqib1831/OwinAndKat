<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TicketsReport.aspx.vb" Inherits="PM_TicketsReport" Theme="Default"  %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Portal HelpDesk Survey Report</title>
     <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
</head>
<body style="height:100%; width:100; text-align:center;">
    <form id="form1" runat="server">
   <div style="height:100%; width:100;">
        <table  cellpadding="0" cellspacing="0" style="height:100%; width:650; text-align:left; border:5px double #EFEFEF; font-size:10pt;">
            <tr>
                <td colspan="5" valign="top">
                    <table align="center" border="0" cellpadding="2" cellspacing="4" width="640">
                        <tr>
                            <td align="center" class="CompanyName" >
                                Portal HelpDesk Survey Report</td>
                        </tr>
                        <tr>
                            <td align="center" class="CompanyName" style="font-size:9pt">
                                <span id="tdTitleReport" runat="server"></span></td>
                        </tr>
                    </table>
                     <asp:ObjectDataSource ID="sdsInbox" runat="server" 
                            SelectMethod="GetFranchiseeSurveyReportForHelpDesk"
                            EnablePaging="false"
                            SortParameterName="sortExpression"
                            TypeName="Portal.BLL.Activities">
                            <SelectParameters>
                              <asp:QueryStringParameter  Name="ClientID" Type="String"  QueryStringField="ClientID" DefaultValue="0" />
                              <asp:Parameter  Name="Search" Type="String" DefaultValue=""  ConvertEmptyStringToNull="true"/>
                              <asp:QueryStringParameter Name="DateFrom" Type="DateTime" QueryStringField="DateFrom" ConvertEmptyStringToNull="true" DefaultValue="1/1/2000" />
                              <asp:QueryStringParameter Name="DateTo" Type="DateTime" QueryStringField="DateTo" ConvertEmptyStringToNull="true" DefaultValue="1/1/2099" />
                              <asp:Parameter Name="startRowIndex" DefaultValue="0"   />
                              <asp:Parameter Name="maximumRows" DefaultValue="1000"   />
                              <asp:Parameter Name="sortExpression" DefaultValue="Ticket DESC"   />
                            </SelectParameters>
                    </asp:ObjectDataSource>  
                </td>
            </tr>
            <tr>
            <td colspan="5" style="border-bottom:double 1px #AAAAAA;">
                &nbsp;
            </td>
            </tr>
            <tr>
                <td colspan="5" align="center" style="padding-right: 10px; padding-left: 10px">
                     <asp:Repeater ID="rptrNotes" runat="server" DataSourceID="sdsInbox"  EnableViewState="false">
                        <HeaderTemplate>
                            <table width="100%" border="0" style="font-size:12px;font-family:Arial;" cellspacing="0" cellpadding="0" >                                                   
                        </HeaderTemplate>
                                <ItemTemplate>
                                  <tr valign="top" style="height:20px;padding-top:10px;padding-bottom:05px;">
                                    <td>
                                       <b>Store:</b>
                                    </td>
                                    <td>
                                       <%# Eval("StoreNick")& " - " & Eval("StoreNumber")%>
                                    </td>
                                  </tr> 
                                  <tr valign="top" style="height:20px;">
                                    <td>
                                       <b>Client:</b>
                                    </td>
                                    <td>
                                       <%# Eval("ClientCode")%>
                                    </td>
                                  </tr> 
                                  <tr valign="top" style="height:20px;">
                                    <td>
                                       <b>Subject:</b> 
                                    </td>
                                    <td>
                                     <%# Functions.IfNull(Eval("Subject"), "") %>
                                    </td>
                                  </tr> 
                                  <tr valign="top" style="height:20px;">
                                    <td>
                                       <b>Initiated By:</b>
                                    </td>
                                    <td>
                                      <%# Eval("ContactName")%> 
                                    </td>
                                  </tr> 
                                  <tr valign="top" style="height:20px;">
                                    <td>
                                       <b>Last Responded By:</b> 
                                    </td>
                                    <td>
                                       <%#Eval("LastUpdateName")%>
                                    </td>
                                  </tr> 
                                  <tr valign="top" style="height:20px;">
                                    <td>
                                       <b>Rating:</b>
                                    </td>
                                    <td>
                                      <%#IIf(Eval("Rate") = 1, "Unsatisfactory", IIf(Eval("Rate") = 2, "Average", IIf(Eval("Rate") = 3, "Good", "Excellent")))%>
                                    </td>
                                  </tr> 
                                  <tr valign="top" style="height:20px;">
                                    <td>
                                     <b> Comments:</b>
                                    </td>
                                    <td>
                                       <%#CType(Eval("RateComments"), String).Replace(vbCrLf, "<br />")%> 
                                    </td>
                                  </tr> 
                                  <tr>  
                                    <td colspan="2" style="border-bottom:solid 1px #AAAAAA;">
                                        &nbsp;
                                    </td>
                                  </tr>                 
                                </ItemTemplate>
                         <FooterTemplate>               
                           </table>
                         </FooterTemplate>
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
        </div>
    </form>
</body>
</html>

