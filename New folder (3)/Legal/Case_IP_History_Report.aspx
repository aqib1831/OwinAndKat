<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Case_IP_History_Report.aspx.vb" Inherits="Case_IP_History_Report" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Franchise Activity History Report</title>
    <link rel="stylesheet" href="../style/style.css" />
    
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>        
    </head>
<body onclick="return false">
    <form id="form1" runat="server">    
                    <div id="ProgressBar"   style=" display:none; position: absolute; position: absolute; width: 200px; height: 15%; left: 38%; top: 38%;" class="MessageDiv">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height: 100%">
                            <tr>
                                <td style="width: 5%;">
                                    &nbsp;</td>
                                <td align="right" valign="middle" style="width: 25%;">
                                    <div style="text-align: right;">
                                        <asp:Image ID="Image2" runat="server" ImageUrl="../images/indicator.gif" ImageAlign="AbsMiddle" />&nbsp;&nbsp;
                                    </div>
                                </td>
                                <td  align="left" valign="middle" id="divMessage" style=" white-space:nowrap; width: 75%;
                                    color: #4B92C1;">
                                    <b>&nbsp;&nbsp;Loading ...</b></td>
                            </tr>
                        </table>
                    </div>
               
    <div>
     
    
    <table width="670" border="0" cellspacing="2" cellpadding="2" align="center" style="font-size: 14pt;">
                    <tr>
                        <td align="center" class="PageSubHeading">
                            <b>[
                                <asp:Label ID="lblCase" runat="server"></asp:Label>] Activity history<b></td>
                    </tr>
                    <tr>
                        <td align="center" class="SimpleBold">
                            Generated On: &nbsp;
                            <%=DateTime.Now.ToLongDateString() %>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="SimpleBold">
                            Reporting Period: &nbsp;<%= Request.QueryString("StartDate")%>
                            &nbsp; to &nbsp;
                            <%=Request.QueryString("EndDate")%>
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 30px;">
                            &nbsp;</td>
                    </tr>
                <tr>
                <td>
                <asp:Literal ID="ltrlNoRecord" runat="server" Visible="false" Text="<table width='100%' border='0' cellspacing='0' cellpadding='0' class='noRecordItalic' style='height:100%;'><tr><td align='center'>No Record Found</td></tr></table>"></asp:Literal>
        <asp:Repeater ID="rptHistoryReport" EnableViewState="false" runat="server" DataSourceID="odsHistoryReport">
            <HeaderTemplate>
                
            </HeaderTemplate>
            <ItemTemplate>
                <table width="670" border="0" cellspacing="2" cellpadding="2" align="center">
                    <tr runat="server" id="trEmptyDataRow" visible="false" class="SimpleLabel" align="Center">
                        <td colspan="2">
                            No Record(s) to show!</td>
                    </tr>
                       <tr class="SimpleLabel">
                        <td>
                            Type: <b>&nbsp;
                                <%#Eval("TypeName")%>
                            </b></td>
                            <td>
                            Date: <b>&nbsp;
                                <%#Eval("Date")%>
                            </b></td>
                    </tr>
                    <tr class="SimpleLabel">
                        <td>
                            Subject: <b>&nbsp;
                                <%#Eval("Subject")%>
                            </b></td>
                         
                    </tr>
                   
                 
                    <tr>
                        <td colspan="2">
                            <asp:HiddenField ID="hdnActivityID" runat="server" Value='<%# Eval("ID") %>' />
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:Repeater ID="rptActivityNotes" runat="server" EnableTheming="True" DataSourceID="ActivityNotesDS">
                                <HeaderTemplate>
                                    <table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color: White;
                                        background: none; border-right: solid 1px white;">
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr style="width: 100%">
                                        <td style="background-color: White; border-bottom: none; padding-left: 0px; padding-top: 5px"
                                            colspan="5">
                                            <span>
                                                <asp:Label ID="lblNotesCaption" runat="server" Text="Notes Added " />
                                                by <b>
                                                    <asp:Label ID="Label1" runat="server" Text='<%#Eval("AdminName")%>'></asp:Label></b></span>
                                            on <b>
                                                <asp:Label ID="Label2" runat="server" Text='<%#Eval("Date") %>'></asp:Label>
                                                - EST</b>
                                            <br />
                                            <br />
                                            <font size="1">Type:&nbsp;<b><asp:Label ID="rptTime" runat="server" Text='<%#CaseMgmt.GetActivityTypeID(CInt(Eval("Type"))) %>'></asp:Label></b>&nbsp;Time
                                                Spent:&nbsp;<b><asp:Label ID="Label5" runat="server" Text='<%# IIF(Eval("TimeSpent").ToString() <> "",Eval("TimeSpent").ToString().Substring(0,5)+" (HH:MM)","&nbsp;") %>'></asp:Label></b><span
                                                    style='<%#iif(eval("cost").tostring()<>"0.0000","width: 200px; background-color: white; border-bottom: none; padding-top: 5px;display:inline;","display:none;") %>'>
                                                    &nbsp;&nbsp;Cost:&nbsp; <b>
                                                        <asp:Label ID="Label6" runat="server" Text='<%#Decimal.Round(Eval("Cost"),2) %>'></asp:Label></b></span></font></td>
                                    </tr>
                                    <tr>
                                        <td style="background-color: White; border-bottom: none; padding-left: 10px;" colspan="5">
                                            <br />
                                            <asp:Repeater ID="Attachments" runat="server" DataSource='<%# Container.DataItem.CreateChildView("NOTE_ATTACH") %>'>
                                                <ItemTemplate>
                                                    [<img src="../images/ico_attachment.gif" style="" align="absmiddle" />
                                                    <a href='<%#ConfigurationManager.AppSettings("CaseAttachPath")+Eval("FilePath") %>'
                                                        target="_blank" style="text-decoration: underline;"><b>
                                                            <asp:Label ID="Label4" runat="server" Text='<%#CaseMgmt.GetAttachmentFileName(Eval("FilePath")) %>'></asp:Label></b></a>&nbsp;&nbsp;]
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="5" style="background-color: White; padding-left: 0px; border-bottom: dashed 0px grey;
                                            padding-right: 10px; width: 540px;">
                                            <br />
                                            <asp:Literal ID="Label3" runat="server" Text='<%#Server.HtmlEncode(CType(Container.DataItem("Notes"),String)).Replace(vbCrLf,"<br />")%>'></asp:Literal><br />
                                            <br />
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </table></FooterTemplate>
                            </asp:Repeater>
                            <asp:ObjectDataSource ID="ActivityNotesDS" runat="server" SelectMethod="GetNotesByActivtyID"
                                TypeName="CaseMgmt">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="hdnActivityID" PropertyName="Value" Name="ActivityID"
                                        Type="Int32" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                            <asp:Literal ID="ltrEmptyMessage" runat="server" Text="No Activity Notes Found!"
                                Visible="false"></asp:Literal>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <hr />
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:Repeater>
   </td></tr></table>
    <asp:ObjectDataSource ID="odsHistoryReport" runat="server" SelectMethod="GetAll_Cases_IP_History" TypeName="CaseMgmt">
    <SelectParameters>
        <asp:QueryStringParameter Name="RequestFrom" Type="INT32" QueryStringField="RequestFrom" />                
        <asp:QueryStringParameter Name="ID" Type="INT32" QueryStringField="ID" />
        <asp:QueryStringParameter Name="StartDate" QueryStringField="StartDate" ConvertEmptyStringToNull="true" Type="DateTime" />        
        <asp:QueryStringParameter Name="EndDate" QueryStringField="EndDate" ConvertEmptyStringToNull="true" Type="DateTime" />            
        <asp:QueryStringParameter Name="Type" QueryStringField="Type" Type="int32"/>
        <asp:QueryStringParameter Name="Search" QueryStringField="Search" ConvertEmptyStringToNull="true" DefaultValue="" Type="string" />
        <asp:Parameter  Name="SortExpression" Type="string" DefaultValue="Date DESC" ConvertEmptyStringToNull="true" />    
        <asp:Parameter  Name="startRowIndex" Type="int32" DefaultValue="0" />    
        <asp:Parameter  Name="MaximumRows" Type="int32" DefaultValue="1000" />    
    </SelectParameters>
    </asp:ObjectDataSource>    
    </div>
    </form>
</body>
</html>











