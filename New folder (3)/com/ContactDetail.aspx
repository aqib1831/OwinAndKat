<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ContactDetail.aspx.vb" Inherits="com_ContactDetail" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Contact Detail</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
</head>
<body style="padding:0px;width:100%; height:100%;">
    <form id="form1" runat="server">
    <asp:HiddenField ID="hdnClientID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnContactID" runat="server" Value="22" />
    <div align="left" id="FrachiseDetail" style="display: inline; padding:0px; position: absolute; overflow-y: auto; height:100%; width:100%; top:0px;">
               <asp:FormView 
                runat="server"
                ID="fvContactDetail"
                Width="100%"
                Height="100%"
                DataSourceID="sdsContactDetail"
                CellPadding="0"
                CellSpacing="0"  >
                <ItemTemplate>                                     
                    <table style="width:100%; height:100%;border-bottom:1px solid #609BD3;"  border="0" align="center" cellpadding="0" cellspacing="0" class="blueSubTableTD">                                                      
                        <tr > 
                            <td style="width:25%;" >&nbsp;Name:</td>
                            <td   align="left" style="height:20px;font-weight:bold;width:75%;">  
                             <%#Eval("FirstName") & " " & Eval("LastName")%> &nbsp;                                                     
                            </td>
                        </tr>      
                        <tr  > 
                            <td  >&nbsp;Address:</td>
                            <td style="height:40px;font-weight:bold;" >
                                <%#Eval("Address1") & "<br /> " & Eval("City") & ", " & Eval("State") & "&nbsp;" & Eval("Zip")%>&nbsp;
                             </td>
                        </tr>                                                  
                        <tr  > 
                            <td >&nbsp;Home Phone:</td>
                            <td style="height:20px;font-weight:bold;">
                                <%#Eval("HomePhone")%>&nbsp;
                            </td>
                        </tr>  
                        <tr  > 
                            <td >&nbsp;Work Phone:</td>
                            <td style="height:20px;font-weight:bold;">
                                <%#Eval("WorkPhone")%>&nbsp;
                            </td>
                        </tr>  
                        <tr  > 
                            <td >&nbsp;Cell Phone:</td>
                            <td style="height:20px;font-weight:bold;">
                                <%#Eval("CellPhone")%>&nbsp;
                            </td>
                        </tr>  
                        <tr  > 
                            <td >&nbsp;Fax:</td>
                            <td style="height:20px;font-weight:bold;">
                                <%# Eval("Fax") %>&nbsp;
                            </td>
                        </tr>                                                                                                     
                        <tr  > 
                            <td >&nbsp;Email:</td>
                            <td style="height:20px;"  >
                                <a href="mailto:<%# Functions.IfNull(Eval("Email1"), "") %>" title="<%# Functions.IfNull(Eval("Email1"), "") %>"> 
                                 <%#Functions.StringTruncate(Functions.IfNull(Eval("Email1"), ""), 25)%></a> <br />
                                 <a href="mailto:<%# Functions.IfNull(Eval("Email2"), "") %>" title="<%# Functions.IfNull(Eval("Email2"), "") %>"> 
                                 <%#Functions.StringTruncate(Functions.IfNull(Eval("Email2"), ""), 25)%></a>&nbsp;
                            </td>
                        </tr> 
                        <tr > 
                            <td style="height:100%;border:0;" align="left" colspan="2">                                                                                   
                            &nbsp;
                            </td>
                        </tr>                                          
                    </table> 
                </ItemTemplate>
                </asp:FormView>
                <asp:SqlDataSource ID="sdsContactDetail" runat="server"
                    ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>" 
                    SelectCommand="Portal_FranchiseContacts_GetByID" 
                    SelectCommandType="StoredProcedure">
                    <SelectParameters>
                      <asp:ControlParameter  Name="ID" Type="Int32" ControlID="hdnContactID" PropertyName="Value" DefaultValue="22" />                      
                    </SelectParameters>
                </asp:SqlDataSource>                
            </div> 
    </form>
</body>
</html>
