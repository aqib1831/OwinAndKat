<%@ Page Language="VB" AutoEventWireup="false" CodeFile="OffSaturdaysSchedulePrintable.aspx.vb"
    Inherits="HR_OffSatudaysSchedulePrintable" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Off-Saturdays Schedules </title>
    <style type="text/css">
        body
        {
            font-family: Calibri;
        }
        table
        {
            font-family: Calibri;
            font-size: 12px;
        }
        .dvDepartmentHeading
        {
            width:100%;
            height:20px;
            text-align:center; 	
            padding-top:3px;
            font-weight:bold;
            clear:both;
            border-top:solid 1px #000000;
            border-bottom:solid 1px #000000;
        }
        .dvEmployeeLeft
        {
            width:100%; 
            float:left; 
            height:20px;
            padding-left:5px; 
            padding-top:3px;
            border-bottom:solid 1px #000000;
            border-right:solid 1px #000000;
        }
        .dvEmployeeLeftWithoutBorder
        {
            width:100%; 
            float:left; 
            height:20px;
            padding-left:5px; 
            padding-top:3px;
            border-bottom:solid 0px #000000;
            border-right:solid 1px #000000;
        }
        .dvEmployeeRight
        {
            width:100%; 
            float:left; 
            height:20px;
            padding-left:5px; 
            padding-top:3px;
            border-bottom:solid 1px #000000;
            border-left:solid 0px #000000;
        }
        .dvEmployeeRightWithoutBorder
        {
            width:100%; 
            float:left; 
            height:20px;
            padding-left:5px; 
            padding-top:3px;
            border-bottom:solid 0px #000000;
            border-left:solid 0px #000000;
            
        }
        .dvEmployeeFooter
        {
            width:100%; 
            float:left; 
            height:20px;
            border-bottom:solid 0px #000000;
            border-left:solid 0px #000000;
            
        }
        #dvOffSaturdayDatesContainer
        {
        	 border:solid 1px #000000; 
        }
    </style>
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
</head>
<body onload="PrintReport();">
    <object id="factory" viewastext style="display: none;" classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814"
        codebase="../ScriptX/smsx.cab#Version=6,3,435,20">
    </object>  
    <form id="form1" runat="server">
    <asp:HiddenField ID="hdnStartDate" runat="server" />
    <asp:HiddenField ID="hdnEndDate" runat="server" />
    <div id="dvRoot">
        <div style="text-align:center; font-family:Calibri; font-size:14px; font-weight:bold;">Netsolace Portal</div>
        <div style="text-align:center; font-family:Calibri; font-size:13px; font-weight:bold;">Schedule of Off Saturdays</div>
        <div style="text-align:center; font-family:Calibri; font-size:13px; font-weight:normall; font-style:italic;">Generated On: <asp:Literal ID="ltrlGeneratedOn" runat="server"></asp:Literal></div>
        <div style="margin-top:10px;">
        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%;">
            <tr>
                <td style="width: 240px; height: 100%; vertical-align: top;">
                    <div id="dvOffSaturdayDatesContainer" style="width: 100%;">
                        <asp:Repeater ID="rptOffSaturdayDates" DataSourceID="sdsGetOffSaturdayDates" runat="server">
                            <HeaderTemplate>
                                <div style="width: 70%; height:20px; padding-top:3px;float: left; background-color: #CCCCCC;
                                    padding-left: 5px; font-weight:bold;">
                                    Saturday/Date</div>
                                <div style="width: 30%; height:20px; padding-top:3px;float: left; background-color: #CCCCCC;
                                    padding-left: 5px;font-weight:bold;border-left:solid 1px #000000;">
                                     <center>   
                                    Off Group</center></div>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div style="width: 70%; height:20px; border-top:solid 1px #000000; padding-top:3px;padding-left: 5px; float: left;">
                                    <asp:Literal ID="ltrlOffSaturdayDate" runat="server" Text='<%#DateTime.Parse(Container.DataItem("OffSaturdayDate")).ToString("MMMM dd, yyyy") %>'></asp:Literal>
                                </div>
                                <div style="width: 30%; padding-top:3px; border-top:solid 1px #000000; border-left:solid 1px #000000; height:20px;float: left; padding-left: 5px;">
                                    <center>
                                        <asp:Literal ID="ltrlOffSaturdayGroup" runat="server" Text='<%#Container.DataItem("GroupType") %>'></asp:Literal>
                                    </center>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </td>
                <td style="width: 40px; height: 100%;">
                    &nbsp;
                </td>
                <td valign="top" style="height: 100%;">
                    <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%;">
                        <tr>
                            <td valign="top">
                                <div style="float: left; width: 48%; border:solid 1px #000000;">
                                    <div style="width: 50%; height:20px;float: left; background-color: #CCCCCC;
                                        padding-left: 5px; padding-top:3px; font-weight:bold;">
                                        Group A</div>
                                    <div style="width: 50%; float: left; background-color: #CCCCCC;
                                        padding-left: 5px; height:20px;border-left:solid 1px #000000;font-weight:bold;padding-top:3px">
                                        Group B</div>
                                    <div id="divListContainerLeft">
                                        <asp:Literal ID="ltrlListLeft" runat="server"></asp:Literal>
                                    </div>
                                </div>
                                <div style="float: right; width: 48%;border:solid 1px #000000;">
                                    <div style="width: 50%; float: left; background-color: #CCCCCC;
                                        padding-left: 5px; height:20px;padding-top:3px; font-weight:bold;">
                                        Group A</div>
                                    <div style="width: 50%; float: left; background-color: #CCCCCC;
                                        padding-left: 5px;height:20px; border-left:solid 1px #000000;padding-top:3px; font-weight:bold;">
                                        Group B</div>
                                    <div id="divListContainerRight">
                                        <asp:Literal ID="ltrlListRight" runat="server"></asp:Literal>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        </div>
    </div>
    <asp:SqlDataSource  ID="sdsGetOffSaturdayDates" runat="server" 
                        SelectCommand="HR_GetOffSaturdayDates" 
                        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter Name="StartDate" ControlID="hdnStartDate" PropertyName="Value" DbType="DateTime" />
            <asp:ControlParameter Name="EndDate" ControlID="hdnEndDate" PropertyName="Value" DbType="DateTime" />
        </SelectParameters>
    </asp:SqlDataSource>
    </form>
</body>
</html>
