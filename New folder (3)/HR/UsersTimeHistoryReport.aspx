<%@ Page Language="VB" AutoEventWireup="false" CodeFile="UsersTimeHistoryReport.aspx.vb" Inherits="HR_UsersTimeHistoryReport" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employee Time History Report</title>
    <script type="text/javascript" language="javascript">
       function bodyOnLoad(){
	    try{
		    window.focus();
		    factory.printing.header = ""
		    factory.printing.topMargin = 0.3;
		    factory.printing.bottomMargin = 0.3;
		    factory.printing.footer = "";
		    initialiseMaxiPT();		
	    }
	    catch(err){
	    }
    }
    </script>
</head>
<body style="height:100%; width:100; text-align:center;" onload="bodyOnLoad();">
    <object id="factory" viewastext style="display: none;" classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814"
        codebase="../ScriptX/smsx.cab#Version=6,3,435,20">
    </object>  
    <form id="form1" runat="server">
    <div style="height:100%; width:100;">
     <asp:HiddenField ID="hdnUserID" runat="server" EnableViewState="False" />
     <asp:HiddenField ID="hdnStartDate" runat="server" EnableViewState="False" />
     <asp:HiddenField ID="hdnEndDate" runat="server" EnableViewState="False" />
    <asp:HiddenField ID="hdnNotes" runat="server" EnableViewState="False" />
    <asp:HiddenField ID="hdnTeamID" runat="server" EnableViewState="False" />
     <table cellpadding="2" cellspacing="4" style="height:100%; width:650; text-align:left; border:5px double #EFEFEF; font-size:10pt;">
         <tr>
            <td colspan="3" class="CompanyName" style="text-align:center; font-family:Arial; font-weight:bold; font-size:15pt;"> 
                Netsolace Portal           
            </td>            
         </tr>
         <tr>
            <td colspan="3" class="CompanyName" style="text-align:center; font-family:Arial; font-weight:bold; font-size:12pt;"> 
                 Employee Time History Report&nbsp;   
            </td>            
         </tr>
         <tr>
            <td colspan="3" class="CompanyName" style="text-align:center; font-weight:normal; font-size:10pt;"> 
                From:
                <asp:label ID="lblFromDate" runat="server" Text=""></asp:label>&nbsp;&nbsp;&nbsp;&nbsp;
                To:
                <asp:label ID="lblToDate" runat="server" Text=""></asp:label>
            </td>            
         </tr>
         <tr>
            <td>
            </td>
            <td>
            </td>
            <td>
            </td>
         </tr>
         <tr>
             <td colspan="3">
                <asp:Repeater ID="srcUserName" runat="server" DataSourceID="srcTimeHistory" EnableViewState="false">
                    <HeaderTemplate>
                        <table width="100%" border="0" cellspacing="0" cellpadding="3" style="font-family:Verdana;font-size:10px;border-bottom:1px solid black">
                          <tr style="height:18px; text-align:left; font-weight:bold; background-color:#EFEFEF;padding:0px;margin:0px;">
                            <td >Employee Name</td>
                            <td >Date</td>
                            <td >Time In</td>
                            <td >Time Out</td>
                            <td >Total Time</td>
                            <td >Notes</td>
                            <td >&nbsp;</td>
                          </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                          <tr>
                            <td colspan="3" valign="bottom" style="background-color:White;height:22px;border-bottom:1px solid #EFEFEF;font-weight:bold;"><%# Container.DataItem("EmployeeName") %></td>
                            <td colspan="4" style="background-color:White; border-bottom:1px solid #EFEFEF;font-weight:bold;">&nbsp;</td><%--<%#FormatNumber(Container.DataItem("TotalMinutes"), 2)%> hrs--%> 
                          </tr>
                        <asp:Repeater id="srcTimeHistoryDetail" runat="server" DataSource='<%# Container.DataItem.CreateChildView("Users_Timings") %>' EnableViewState="false">
                            <ItemTemplate>
                                  <tr style="background-color:White; height:22px; border-bottom:1px solid #C9EAFC;">
                                    <td style=" border-bottom:1px solid #EFEFEF;width:2%">&nbsp;</td>
                                    <td style=" border-bottom:1px solid #EFEFEF;width:16%"  id='datein_<%#Container.DataItem("ID")%>'><%#String.Format("{0:MMM dd, yyyy}", Container.DataItem("PunchInTime"))%></td>
                                    <td style=" border-bottom:1px solid #EFEFEF;width:12%"  id='timein_<%#Container.DataItem("ID")%>'><%#String.Format("{0:hh:mm tt}", Container.DataItem("PunchInTime"))%></td>
                                    <td style=" border-bottom:1px solid #EFEFEF;width:14%" id='timeout_<%#Container.DataItem("ID")%>'><%#String.Format("{0:hh:mm tt}", Container.DataItem("PunchOutTime"))%> </td>
                                    <td style=" border-bottom:1px solid #EFEFEF;width:18%"><strong><%#Container.DataItem("CurrentHours")%></strong> hrs : <strong><%#Container.DataItem("CurrentMinutes")%></strong> min</td>
                                    <td style=" border-bottom:1px solid #EFEFEF; width:35%;" id='notes_<%#Container.DataItem("ID")%>'><%#Functions.IfNull(Container.DataItem("LastUpdatedNotes"), "&nbsp;")%></td>
                                    <td style=" border-bottom:1px solid #EFEFEF;width:2%">&nbsp;</td>                                            
                                  </tr>                        
                            </ItemTemplate>
                        </asp:Repeater>
                         <tr>
                            <td colspan="4" style="background-color:White; height:22px; border-bottom:2px solid #EFEFEF;">&nbsp;</td>
                            <td colspan="3" style="background-color:White; height:22px; border-bottom:2px solid #EFEFEF;"><%#Container.DataItem("EmployeeName") & "'s Total Time : <strong>" & Container.DataItem("CurrentHours") & "</strong>"%> hrs : <strong><%#Container.DataItem("CurrentMinutes") %></strong> min</td>
                         </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                    </table>
                    </FooterTemplate>
                </asp:Repeater>
                <asp:ObjectDataSource 
                    ID="srcTimeHistory" 
                    runat="server" 
                    TypeName="Portal.BLL.HR.HR_Activities" 
                    SelectMethod="GetTimeHistoryReport"
                    EnablePaging="false" EnableViewState="False">
                   <SelectParameters>
                        <asp:ControlParameter Name="FromDate" ControlID="hdnStartDate" Type="DateTime" />
                        <asp:ControlParameter Name="ToDate" ControlID="hdnEndDate" Type="DateTime" />
                        <asp:ControlParameter Name="UserID" ControlID="hdnUserID" DefaultValue="0" Type="Int32" />
                        <asp:Parameter  DefaultValue="" Name="txtsearch" Type="String" />                                   
                   </SelectParameters>
                 </asp:ObjectDataSource>            
             </td>
         </tr>
         <tr>
            <td style="font-style:italic; font-size:7pt;">
                Printed Online <asp:label ID="lblPrintDate" runat="server" Text=""></asp:label>
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
