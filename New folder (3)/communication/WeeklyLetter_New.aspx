<%@ Page Language="VB" AutoEventWireup="false" CodeFile="WeeklyLetter_New.aspx.vb" Inherits="admin_comm_WeeklyLetter_New" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>New WeeklyLetter</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <link href="../App_Themes/Default/Calendar/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
</head>

<body style="margin:0px;padding:0px;border:0px;height:100%;background-color: #daf5d6;" scroll="No">
    <form id="form1" runat="server">
    <div >
    <table border="0" cellpadding="5" cellspacing="0" style="width:100%;height:100%;">
            <tr class="HeaderRowGreen">
                <td style="height:30px;border-bottom:#609bd3 1px solid;">
                    &nbsp;<asp:Label ID="lblHeading" runat="server" Font-Bold="True" Font-Size="12px" Text="New Weekly Letter"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="height:40px;">
                    <table border="0" cellpadding="0" cellspacing="0" style="width:100%;font-size:12px;">
                        <tr >
                            <td style="width:50px">
                                Title : <span class="RequiredField">*</span></td>
                            <td style="width:280px">
                                <asp:TextBox ID="txtTitle" runat="server" MaxLength="50" Rows="1" Width="250px"></asp:TextBox></td>
                            <td style="width:80px">
                                From Date : <span class="RequiredField">*</span></td>
                            <td style="width:120px" align="left">
                                <asp:TextBox ID="txtFromDate" runat="server" onfocus="imgFromCalander.click();" onclick="imgFromCalander.click();" Width="80px"></asp:TextBox><img
                                    id="imgFromCalander" align="absMiddle" border="0" onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtFromDate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                                    onmouseover="style.cursor='hand';" src="../../images/ico_calendar.jpg" style="display: none" /></td>
                            <td style="width:80px">
                                To Date : <span class="RequiredField">*</span></td>
                            <td style="width:140px" align="left">
                                <asp:TextBox ID="txtToDate" runat="server" onfocus="imgToCalander.click();" onclick="imgToCalander.click();" Width="80px"></asp:TextBox><img
                                    id="imgToCalander" align="absMiddle" border="0" onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtToDate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                                    onmouseover="style.cursor='hand';" src="../../images/ico_calendar.jpg" style="display: none" /></td>
                        </tr>
                        <tr valign="top">
                            <td >
                            </td>
                            <td >
                                <asp:RequiredFieldValidator ID="val_Title" runat="server" ControlToValidate="txtTitle"
                                    CssClass="RequiredField" ErrorMessage="Please enter Title" Display="Dynamic"></asp:RequiredFieldValidator><asp:Label
                                        ID="lblOutput" runat="server" CssClass="RequiredField"></asp:Label>
                                <asp:RegularExpressionValidator ID="revQuote" runat="server" ControlToValidate="txtTitle"
                                    CssClass="RequiredField" Display="Dynamic" ErrorMessage="Please enter valid text."
                                    ValidationExpression="^[^<>]*$"></asp:RegularExpressionValidator></td>
                            <td >
                            </td>
                            <td >
                                <asp:RequiredFieldValidator ID="vald_FromDate" runat="server" ControlToValidate="txtFromDate"
                                    CssClass="RequiredField" ErrorMessage="Please select from date" Display="Dynamic"></asp:RequiredFieldValidator></td>
                            <td >
                            </td>
                            <td >
                                <asp:RequiredFieldValidator ID="val_ToDate" runat="server" ControlToValidate="txtToDate"
                                    CssClass="RequiredField" ErrorMessage="Please select to date" Display="Dynamic"></asp:RequiredFieldValidator><asp:CompareValidator
                                        ID="vald_Comparedate" runat="server" ControlToCompare="txtFromDate" ControlToValidate="txtToDate"
                                        CssClass="RequiredField" ErrorMessage="From Date greater than To Date"
                                        Operator="GreaterThan" Type="Date" Display="Dynamic"></asp:CompareValidator></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="height:30px;background-color:#bde4b8;border-bottom:#609bd3 1px solid;border-top:#609bd3 1px solid;">
                    <span style="font-weight:bold">Weekly Letter Templates</span></td>
            </tr>
            <tr>
                <td valign="top" style="height:80%;">
                <div id="dlstScroll"  class="DivScroll" style="height:100%; padding-top:5px;padding-bottom:5px; overflow-y:auto">
                    <asp:DataList ID="dlstTemplates" runat="server" DataKeyField="ID" RepeatColumns="3">
                        <ItemTemplate>
                            <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                <tr>
                                    <td align="right" style="padding-right: 3px;" valign="top">
                                        <asp:RadioButton ID="rbtTemplate" runat="server" GroupName="temp" /></td>
                                    <td style="padding-right:10px;">
                                        <asp:Image ID="imgTemplate" runat="server" Height="200px" ImageUrl='<%# "~/communication/WeeklyLetterTemplates/images/"+Eval("ImagePath") %>'
                                            Width="200px" BorderWidth="3"  BorderStyle="double"  BorderColor="black"   /></td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td align="center" style="font-weight: bold; height: 27px;">
                                        <asp:Label ID="lblTemplateName" runat="server" Text='<%# Eval("TemplateName") %>'></asp:Label></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:DataList>
                    </div>
                </td>
            </tr>
            <tr class="HeaderRowGreen">
                <td align="right" style="height:30px;border-top: #609bd3 1px solid;" >
                    <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" CssClass="Btn3D"  Text="Save"/>&nbsp;
                    <asp:Button ID="btnCancel" runat="server" OnClick="btnCancel_Click" CssClass="Btn3D" Text="Cancel" CausesValidation="false"/>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>    

<script language="javascript" type="text/javascript">
        function SetUniqueRadioButton(nameregex, current)
		 {
			re = new RegExp(nameregex);  
			for(i = 0; i < document.forms[0].elements.length; i++) 
			{
				elm = document.forms[0].elements[i]

				if (elm.type == 'radio') 
				{					
					elm.checked = false;					
				}
			}			
			document.getElementById(current).checked=true
		  }   
		  		 		
 </script>    
</html>
