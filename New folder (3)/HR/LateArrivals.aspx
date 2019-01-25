<%@ Page Language="VB" AutoEventWireup="false" CodeFile="LateArrivals.aspx.vb" Inherits="HR_LateArrivals" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>  
    <style type="text/css">
         .rptPrintable
        {
	        font-family: Arial, Verdana, Helvetica, sans-serif;
	        font-size:12px;
	        text-align:left;
        }

        .rptPrintable th
        {
	        font-weight:bold; text-align:left;	text-decoration:none;
	        padding:3px 0px 3px 2px; 
	       border-top:solid 2px #CCCCCC;
        }

        .rptPrintable td
        {
	        text-decoration:none;	
	        padding:2px 0px 2px 1px; 
        }

        .CompanyName
        {
	        font-family: Arial, Verdana, Helvetica, sans-serif;
	        font-size:14px;	font-weight:bold;
	        padding:3px 0px 3px 0px;
        }

        .ReportTitle
        {
	        font-family: Arial, Verdana, Helvetica, sans-serif;
	        font-size:13px;	font-weight:bold;
	        padding:3px 0px 3px 0px;
        }

        .GeneratedOn
        {
	        font-family: Arial, Verdana, Helvetica, sans-serif;
	        font-size:11px;
	        padding:3px 0px 3px 0px;
        } 
        
        .hdng_Section
        {
	       font-family: Arial, Verdana, Helvetica, sans-serif;
	       font-size:12px; font-weight:bold;
	       background:#EEEEEE;	       	   
	       border-top:solid 2px #CCCCCC;
	       border-bottom:solid 1px #CCCCCC;    	       
        }  
    </style>  
</head>
<body>    
    <form id="form1" runat="server">
    <div>  
        <table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
            <tr>
                <td align="center" style="padding-top:5px;">
                    <asp:Label ID="lblCompanyName" runat="server" EnableViewState="false" CssClass="CompanyName"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Label ID="lblReportTitle" runat="server" EnableViewState="false" CssClass="ReportTitle"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="GeneratedOn" align="center">
                    Generated On: <%=String.Format("{0: dd, MMM yyyy hh:mm tt}", Functions.GetTimeByZone(ConfigurationManager.AppSettings("NetsolaeIsbTimeOffset"), Date.Now))%>  
                </td>
            </tr>            
            <tr>
                <td align="center">
                    <table cellpadding="0" border="0" cellspacing="0" style="width:670px" class="rptPrintable">
                        <tr>
                            <th style="width:170px;">Employee Name</th>
                            <th style="width:150px;">Department</th>                                                      
                            <th style="width:110px;">Punch In</th>
                            <th style="width:150px;">Yesterday Punch Out</th>
                        </tr>
                        <tr>
                            <td class="hdng_Section" colspan="4" style="padding:3px 0px 3px 5px;">Late Arrivals</td>
                        </tr>
                        <asp:Repeater ID="rptEmployeesLaterArrived" runat="server" EnableViewState="False">                        
                            <ItemTemplate>
                                <tr>
                                    <td style="width:170px;"><%# Eval("EmployeeName")%></td>
                                    <td style="width:150px;"><%# Eval("DepartmentName")%></td>                                    
                                    <td style="width:110px;"><%# String.Format("{0:hh:mm tt}",  Functions.IfNull(Eval("PunchInTime"), "-"))%></td>
                                    <td style="width:150px;"><%# String.Format("{0:hh:mm tt}", Functions.IfNull(Eval("LastDayPunchOutTime"), "-"))%></td>                                
                                </tr>
                            </ItemTemplate>                       
                        </asp:Repeater>    
                        <tr id="trNoLateArrivedEmployees" runat="server" visible="false">
                            <td align="center" colspan="4" style="padding:5px 0px 5px 0px;">
                                <asp:Literal ID="ltrlNoLateArrivedEmployees" runat="server" EnableViewState="false"></asp:Literal>
                            </td>
                        </tr>
                      </table>                                        
                </td>
            </tr>            
            <tr>
                <td align="Center">
                    <table cellpadding="0" border="0" cellspacing="0" style="width:670px" class="rptPrintable">
                        <tr>
                            <td class="hdng_Section" colspan="4" style="padding:3px 0px 3px 5px;">Absent</td>
                        </tr>
                        <asp:Repeater ID="rptEmployeesAbsent" runat="server" EnableViewState="False">                        
                        <ItemTemplate>
                            <tr>
                                <td style="width:170px;"><%# Eval("EmployeeName")%></td>
                                <td style="width:150px;"><%# Eval("DepartmentName")%></td>                                
                                <td style="width:110px;"><%# String.Format("{0:hh:mm tt}",  Functions.IfNull(Eval("PunchInTime"), "-"))%></td>
                                <td style="width:150px;"><%# String.Format("{0:hh:mm tt}", Functions.IfNull(Eval("LastDayPunchOutTime"), "-"))%></td>                                
                            </tr>
                        </ItemTemplate>                            
                        </asp:Repeater>
                        <tr id="trNoAbsentEmployees" runat="server" visible="false">
                            <td align="center" colspan="4" style="padding:5px 0px 5px 0px;">
                                <asp:Literal ID="ltrlNoAbsentEmployees" runat="server" EnableViewState="false"></asp:Literal>
                            </td>
                        </tr>
                     </table>                    
                </td>
            </tr>
        </table>         
    </div>
    </form>
</body>
</html>
