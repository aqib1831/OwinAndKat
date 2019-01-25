<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TempEmployeeTimeHistoryInDetail_Printable.aspx.vb"
    Inherits="tempHR_EmployeeTimeHistoryInDetail_Printable" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script type="text/javascript" language="javascript" src="../scripts/jquery-1.3.2.min.js"></script>

    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>

    <script language="javascript" type="text/javascript">
        function PrintReport() {
            SetPrintSettings();
           window.focus();
           window.print();
       }
       function SetPrintSettings() {

           factory.printing.portrait = false;
           factory.printing.leftMargin = 0.5;
           factory.printing.topMargin = 0.3;
           factory.printing.rightMargin = 0.5;
           factory.printing.bottomMargin = 0.8;
       } 

    </script>

    <style type="text/css" media="print">
        .landScape
        {
             width: 100%; 
             height: 100%; 
             margin: 0px; 
             padding: 0px; 
             /*filter: progid:DXImageTransform.Microsoft.BasicImage(Rotation=3);*/
        }
        .Footer
        {
            page-break-after: always;
        }
        #dvBody
        {
            font-family: Calibri;
            font-size: 10px;
            font-weight: normal;
        }
        .Header
        {
            text-align: center;
            page-break-after: always;
        }
        .ReportCaption
        {
            font-size: 16px;
            font-weight: bold;
            margin-top:5px;
        }
        .ReportTitleCaption
        {
            font-size: 15px;
            font-weight: bold;
        }
        .ReportPeriodCaption
        {
            margin: 5px;
        }
        .ReportPeriodCaption span
        {
             font-size:12px;	
        }
        .EmployeeDetails
        {
            text-align: left;
            margin-top: 5px;
            margin-bottom: 5px;
            font-family: Calibri;
            font-weight: bold;
            font-size: 12px;
        }
        .tdDateCaption
        {
            width: 100px;
            font-size:12px;
            border-bottom: solid 1px #000000;
            border-right: solid 1px #000000;
            border-left: solid 1px #000000;
            border-top: solid 1px #000000;
            padding-left: 5px;
            font-weight: bold;
        }
        .tdDate
        {
            width: 100px;
            font-size:12px;
            border-bottom: solid 1px #000000;
            border-right: solid 1px #000000;
            border-left: solid 1px #000000;
            border-top: solid 0px #000000;
            text-align: center;
            vertical-align: top;
        }
        .tdRemarksCaption
        {
            border-bottom: solid 1px #000000;
            border-right: solid 1px #000000;
            border-left: solid 0px #000000;
            border-top: solid 1px #000000;
            padding-left: 5px;
            font-weight: bold;
            font-size:12px;
        }
        .tdRemarks
        {
            border-bottom: solid 1px #000000;
            border-right: solid 1px #000000;
            border-left: solid 0px #000000;
            border-top: solid 0px #000000;
            padding-left: 5px;
            text-align: left;
            font-size:12px;
        }
        .tdPunchCellsCaption
        {
            width: 100px;
            border-bottom: solid 1px #000000;
            border-right: solid 1px #000000;
            border-left: solid 0px #000000;
            border-top: solid 1px #000000;
            font-size:12px;
        }
        .tdPunchCells
        {
            width: 100px;
            border-bottom: solid 1px #000000;
            border-right: solid 1px #000000;
            border-left: solid 0px #000000;
            border-top: solid 0px #000000;
            text-align: center;
            vertical-align: top;
            font-size:12px;
        }
        .PunchCell
        {
            text-align: center;
            border-bottom: solid 1px #000000;
            border-right: solid 1px #000000;
            border-left: solid 0px #000000;
            border-top: solid 0px #000000;
            width: 80px;
        }
        .tdTotalHrsCaption
        {
            text-align: center;
            border-bottom: solid 1px #000000;
            border-right: solid 1px #000000;
            border-left: solid 1px #000000;
            border-top: solid 1px #000000;
            width: 100px;
            height: 25px;
            font-weight: bold;
            font-size:12px;
        }
        .tdTotalHrs
        {
            text-align: center;
            border-bottom: solid 1px #000000;
            border-right: solid 1px #000000;
            border-left: solid 1px #000000;
            border-top: solid 0px #000000;
            width: 100px;
            height: 25px;
            vertical-align: top;
            padding-top:15px;
            font-size:12px;
        }
    </style>
    <style type="text/css" media="screen">
        
        #dvBody
        {
            font-family: Calibri;
            font-size: 10px;
            font-weight: normal;
        }
        .Header
        {
            text-align: center;
        }
        .ReportCaption
        {
            font-size: 16px;
            font-weight: bold;
            margin-top:5px;
        }
        .ReportTitleCaption
        {
            font-size: 15px;
            font-weight: bold;
        }
        .ReportPeriodCaption
        {
            margin: 5px;
        }
        .ReportPeriodCaption span
        {
             font-size:12px;	
        }
        .EmployeeDetails
        {
            text-align: left;
            margin-top: 5px;
            margin-bottom: 5px;
            font-family: Calibri;
            font-weight: bold;
            font-size: 12px;
        }
        .tdDateCaption
        {
            width: 100px;
            font-size:12px;
            border-bottom: solid 1px #000000;
            border-right: solid 1px #000000;
            border-left: solid 1px #000000;
            border-top: solid 1px #000000;
            padding-left: 5px;
            font-weight: bold;
        }
        .tdDate
        {
            width: 100px;
            border-bottom: solid 1px #000000;
            border-right: solid 1px #000000;
            border-left: solid 1px #000000;
            border-top: solid 0px #000000;
            text-align: center;
            vertical-align: top;
            font-size:12px;
        }
        .tdRemarksCaption
        {
            border-bottom: solid 1px #000000;
            border-right: solid 1px #000000;
            border-left: solid 0px #000000;
            border-top: solid 1px #000000;
            padding-left: 5px;
            font-weight: bold;
        }
        .tdRemarks
        {
            border-bottom: solid 1px #000000;
            border-right: solid 1px #000000;
            border-left: solid 0px #000000;
            border-top: solid 0px #000000;
            padding-left: 5px;
            text-align: left;
        }
        .tdPunchCellsCaption
        {
            width: 100px;
            border-bottom: solid 1px #000000;
            border-right: solid 1px #000000;
            border-left: solid 0px #000000;
            border-top: solid 1px #000000;
            font-size:12px;
        }
        .tdPunchCells
        {
            width: 100px;
            border-bottom: solid 1px #000000;
            border-right: solid 1px #000000;
            border-left: solid 0px #000000;
            border-top: solid 0px #000000;
            text-align: center;
            vertical-align: top;
            font-size:12px;
        }
        .PunchCell
        {
            text-align: center;
            border-bottom: solid 1px #000000;
            border-right: solid 1px #000000;
            border-left: solid 0px #000000;
            border-top: solid 0px #000000;
            width: 80px;
        }
        .tdTotalHrsCaption
        {
            text-align: center;
            border-bottom: solid 1px #000000;
            border-right: solid 1px #000000;
            border-left: solid 1px #000000;
            border-top: solid 1px #000000;
            width: 100px;
            height: 25px;
            font-weight: bold;
        }
        .tdTotalHrs
        {
            text-align: center;
            border-bottom: solid 1px #000000;
            border-right: solid 1px #000000;
            border-left: solid 1px #000000;
            border-top: solid 0px #000000;
            width: 100px;
            height: 25px;
            vertical-align: top;
            padding-top:15px;
        }
        .TRPunchRecord
        {
            page-break-before: always;
        }
    </style>
</head>
<body onLoad="PrintReport();" class="landScape">
    <object id="factory" viewastext style="display: none;" classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814"
        codebase="../ScriptX/smsx.cab#Version=6,3,435,20">
    </object>  

    <form id="form1" runat="server">
    <div id="dvBody">
        <asp:HiddenField ID="hdnStartDate" runat="server" />
        <asp:HiddenField ID="hdnEndDate" runat="server" />
        <asp:HiddenField ID="hdnDepartmentID" runat="server" />
        <asp:HiddenField ID="hdnEmployeeID" runat="server"></asp:HiddenField>
        <asp:HiddenField ID="hdnTeamID" runat="server"></asp:HiddenField>
        <asp:HiddenField ID="hdnStatus" runat="server"></asp:HiddenField>
        <asp:Repeater ID="rptUsers" runat="server" DataSourceID="odsTimeHistory">
            <ItemTemplate>
                <div class="Header" id="dvHeader" runat="server">
                    <div class="ReportCaption">
                        Netsolace Portal</div>
                    <div class="ReportTitleCaption">
                        Employee Time History Report</div>
                    <div class="ReportPeriodCaption">
                        <span>From:</span><span style="padding-left:3px;"><asp:Literal ID="ltrlStartDate" runat="server"></asp:Literal></span>
                        <span style="padding-left:10px;">To:</span><span style="padding-left:3px;"><asp:Literal ID="ltrlEndDate" runat="server"></asp:Literal></span>
                        
                    </div>
                     <div class="ReportPeriodCaption">
                        <span>Generated On:</span><span style="padding-left:3px;"><%=DateTime.Now.ToString("MM/dd/yyyy hh:mm tt")%></span>
                    </div>
                    <div class="EmployeeDetails">
                        <asp:Literal ID="ltrlEmployeeName" runat="server" Text='<%#Eval("FullName") %>'></asp:Literal>&nbsp;(<asp:Literal
                            ID="ltrlDepartmentName" runat="server" Text='<%#Eval("Department")%>'></asp:Literal>,<asp:Literal
                                ID="ltrlTeamName" runat="server" Text='<%#Eval("TeamName")%>'></asp:Literal>)
                    </div>
                    <div style="width: 100%;">
                        <asp:Repeater ID="rptAttendence" runat="server" DataSource='<%#Container.DataItem.CreateChildView("Users_Attendence") %>'
                            OnItemDataBound="rptAttendence_ItemDataBound">
                            <HeaderTemplate>
                                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%;">
                                    <tr>
                                        <td class="tdDateCaption" style="height:20px;">
                                            Date
                                        </td>
                                        <td class="tdPunchCellsCaption" style="height:20px;">&nbsp;
                                            
                                        </td>
                                        <td class="tdTotalHrsCaption" style="height:20px; font-size:12px;">
                                            Total Hours
                                        </td>
                                        <td class="tdRemarksCaption" style="height:20px;font-size:12px;">
                                            Remarks
                                        </td>
                                    </tr>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr id="trItemHeader" runat="server" visible="false">
                                    <td class="tdDateCaption" style="height:20px;">
                                        Date
                                    </td>
                                    <td class="tdPunchCellsCaption" style="height:20px;">&nbsp;
                                        
                                    </td>
                                    <td class="tdTotalHrsCaption" style="height:20px;font-size:12px;">
                                        Total Hours
                                    </td>
                                    <td class="tdRemarksCaption" style="height:20px;font-size:12px;">
                                        Remarks
                                    </td>
                                </tr>
                                <tr id="trRptPunchInRecord" runat="server" visible="false" class="TRPunchRecord">
                                    <td class="tdDate" style="height:20px;padding-top:0px; padding-top:6px;">
                                        <Div><%#DateTime.Parse(Eval("PunchInDate")).ToString("ddd")%>, <%#DateTime.Parse(Eval("PunchInDate")).ToString("MMM dd/yy")%></Div>
                                    </td>
                                    <td class="tdPunchCells" style="height:20px; padding-top:0px;">
                                        <asp:Repeater ID="rptPunchIns" runat="server" OnItemDataBound="rptPunchIns_ItemDataBound">
                                            <HeaderTemplate>
                                                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%;">
                                                    <tr>
                                                        <td style="vertical-align:top;">
                                                            <div class="PunchCell" style="border-bottom: solid 1px #000000;font-size:10px; font-weight: bold; width:50px;">
                                                                IN
                                                            </div>
                                                            <div class="PunchCell" style="font-weight: bold;width:50px;font-size:10px;font-weight: bold;border-bottom: solid 1px #000000;">
                                                                OUT
                                                            </div>
                                                        </td>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <td id="tdPunchCellContainer" runat="server" style="vertical-align:top;" >
                                                    <div class="PunchCell" style="border-bottom: solid 1px #000000;font-size:10px;">
                                                        <asp:Literal ID="ltrlPunchIn" runat="server"></asp:Literal>
                                                    </div>
                                                    <div class="PunchCell" style="font-size:10px;">
                                                        <asp:Literal ID="ltrlPunchout" runat="server"></asp:Literal>
                                                    </div>
                                                </td>
                                                <td id="tdAbsentContainer" runat="server" visible="false" style="text-align:center;font-size:11px; height:20px; padding-left:20px; ">
                                                   <center>
                                                        <asp:Literal ID="ltrlAbsentNote" runat="server"></asp:Literal>
                                                    </center>
                                                </td>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                </tr> </table>
                                            </FooterTemplate>
                                        </asp:Repeater>
                                    </td>
                                    <td class="tdTotalHrs" style="height:20px;padding-top:6px; font-size:12px;">
                                        <asp:Literal ID="ltrlCurrentWorkingDay" runat="server"></asp:Literal>
                                    </td>
                                    <td class="tdRemarks" style="font-size:9px;height:20px;padding-top:0px;font-size:8px;">
                                        <span>
                                            <asp:Literal ID="ltrlCurrentFlags" runat="server"></asp:Literal>
                                        </span>
                                        <br />
                                        <span>
                                            <asp:Literal ID="ltrlComments" runat="server"></asp:Literal></span>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                <tr>
                                    <td style="width: 100px; height: 32px; border: solid 1px #000000; padding-left: 5px;">
                                        <b>Total</b>
                                    </td>
                                    <td style="width: 100px; height: 32px; border: solid 1px #000000; padding-left: 5px;">&nbsp;
                                        
                                    </td>
                                    <td style="width: 100px; text-align: center; height: 32px; border: solid 1px #000000;">
                                        <asp:Literal ID="ltrlTotalHours" runat="server"></asp:Literal>
                                    </td>
                                    <td style="height: 32px; border: solid 1px #000000; padding-left: 5px;">&nbsp;
                                        
                                    </td>
                                </tr>
                                </table>
                                <div style="float:left; margin-top:20px; text-align:left; font-family:Calibri; font-size:14px; font-weight:bold; ">
                                    <asp:Literal ID="ltrlTotalFlags" runat="server"></asp:Literal>
                                </div>
                                
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <asp:ObjectDataSource ID="odsTimeHistory" runat="server" EnableViewState="true" TypeName="Portal.BLL.HR.HR_UserTimeHistory"
            SelectMethod="GetEmployeesTimeHistoryDetail_Printable" EnablePaging="false">
            <SelectParameters>
                <asp:ControlParameter ControlID="hdnStartDate" Name="StartDate" PropertyName="Value"
                    Type="DateTime" />
                <asp:ControlParameter ControlID="hdnEndDate" Name="EndDate" PropertyName="Value"
                    Type="DateTime" />
                <asp:ControlParameter Name="DepartmentID" ControlID="hdnDepartmentID" DefaultValue="0"
                    Type="int32" />
                <asp:ControlParameter Name="EmployeeID" ControlID="hdnEmployeeID" DefaultValue="0"
                    Type="int32" />
                <asp:ControlParameter Name="TeamID" ControlID="hdnTeamID" DefaultValue="0" Type="int32" />
                <asp:ControlParameter Name="Status" ControlID="hdnStatus" DefaultValue="0" Type="int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </div>
    </form>
</body>
</html>
