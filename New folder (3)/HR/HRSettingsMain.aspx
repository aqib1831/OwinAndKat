<%@ Page Language="VB" AutoEventWireup="false" CodeFile="HRSettingsMain.aspx.vb" Inherits="HR_SettingsMain" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css"/>
    <style type="text/css">
    #trTitle
    {
	    background-image: url('../images/bg_mainHdr_1.jpg');height: 31px;	
    }
    </style>
</head>
<body style="margin:0px; padding:0px;">
    <form id="form1" runat="server">
    <div>
        <table border="0" cellpadding="0" cellspacing="0" style="width:100%; height:100%; background-color:#EBEBEB">
        <tr id="trTitle">
            <td style="width:100%; height:31px;">
                <span style="font-size:14px; font-weight:bold; padding-left:5px;">
                    Off Saturday Schedules
                </span>
            </td>
        </tr>
        <tr>
            <td style="height:100%; width:100%; vertical-align:middle; text-align:center;">
                <iframe id="iframe1" name="iframeReport" src="../BlankPage.htm" style="width:100%; height:100%" scrolling="auto"></iframe>    
                <%--<center>
                    <div>
                        <input type="button" class="btnSimple"  name="btnPrintOffSaturdaySchedule" 
                            value="Print Off Saturday Schedule"  style="width:150px; height:31px;"  onclick="PrintSchedule();"/>
                    </div>
                </center>--%>
            </td>
        </tr>
        </table>
    </div>
    <%--<iframe id="iframeReport" name="iframeReport" scrolling="no" src="../BlankPage.htm" style="width:1px; height:1px"></iframe>    --%>
    <script language="javascript" type="text/javascript">
        function PrintSchedule() {
            document.getElementById('iframeReport').src = 'OffSaturdaysSchedulePrintable.aspx?Nocache='+new Date();
        }
        PrintSchedule();
    </script>
    </form>
</body>
</html>
