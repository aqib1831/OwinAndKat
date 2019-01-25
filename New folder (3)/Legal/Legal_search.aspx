<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Legal_search.aspx.vb" Inherits="admin_Legal_Legal_search" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Search</title>
<link href="../../style/style.css" type="text/css" rel="stylesheet" />
    <link href="Style/Style.css" type="text/css" rel="stylesheet" />
    <link href="../../style/Calendar/style.css" type="text/css" rel="stylesheet" />
    <script language="javascript" type="text/javascript">
          function ShowResults(ID,type,Parent)
	    {
	        if(type==1)
	        {
	            parent.frameMain.location='IPMain.aspx?ID='+ID;
	        }
	        if(type==2)
	        {
	            parent.frameMain.location='VendorProfile.aspx?FirmID='+ID;
	        }
	        if(type==3)
	        {
	            parent.frameMain.location='CaseMain.aspx?ID='+ID;
	        }
	        if(type==4)
	        {
	             parent.frameMain.location='CaseMain.aspx?ID='+Parent+'&ActivityID='+ID;
	             //parent.frameMain.RightFrame.location='NewCaseNote.aspx?ID='+ID;
	        }
	        if(type==5)
	        {
	             parent.frameMain.location='IPMain.aspx?ID='+Parent+'&ActivityID='+ID;
	             //parent.frameMain.RightFrame.location='NewActivityNote.aspx?ID='+ID;
	        }
	        
	    }
    </script>

</head>
<body class="ScrollBarHomeTicket">
    <form id="form1" runat="server">
        <div id="DIV1" runat="server">
            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="Legal_Search">
                <HeaderTemplate>
                    <table style="text-align: left; width: 100%; background-color: White; margin: 0px;
                        padding: 0px;" cellpadding="0" cellspacing="0">
                </HeaderTemplate>
                <ItemTemplate>
                    <tr style="font-size: 11px; font-family: Arial, Helvetica, Sans-Serif; text-align: left;
                        font-size: 12px; padding-left: 0.5em; border-bottom: 2px inset #E5F1FB; cursor: pointer;
                        height: 22px; padding-right: 0px;" onclick="ShowResults(<%#Container.DataItem("ID")%>,<%#Container.DataItem("Page") %>,<%#Container.DataItem("Parent") %>);" onmouseover="this.className='HighlightedHomeRow';" onmouseout="this.className='SimpleHomeRow';">
                        <td style="width: 10px; height: 20px; border-bottom: 2px inset #E5F1FB;">
                            <img src='<%#IIF(cint(Eval("Page"))=1 OR cint(Eval("Page"))=5,"images/ip.gif",IIF(cint(Eval("Page"))=3 OR cint(Eval("Page"))=4,"images/Case.gif","images/Firm.png")) %>' />
                        </td>
                        <td style="font-size: 11px; font-family: Arial, Helvetica, Sans-Serif; text-align: left;
                            font-size: 12px; padding-left: 0.5em; border-bottom: 2px inset #E5F1FB; cursor: pointer;
                            height: 22px; padding-right: 0px;" title='<%#Eval("SearchText").ToString() %>'>
                            <asp:Label ID="Label1" runat="server" Text='<%#IntellectualProperty.TrimSearchResults(Server.HtmlEncode(Eval("SearchText").ToString())) %>'></asp:Label>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    <tr id="trNoRec" runat="server" visible="false">
                        <td align="center" valign="middle" style="height: 100%">
                            <div id="divInfo" class="MessageDiv" style="left: 10%; margin: 5px; width: 170px;
                                position: absolute; top: 35%; height: 50px">
                                <table border="0" cellpadding="0" cellspacing="0" style="width: 160px; height: 50px">
                                    <tr>
                                        <td align="right" style="width: 25%" valign="middle">
                                            <div style="text-align: right">
                                                <asp:Image ID="Image1" runat="server" ImageUrl="~/images/icn_info.gif" />
                                                &nbsp; &nbsp;</div>
                                        </td>
                                        <td id="divMessage" align="left" nowrap="nowrap" valign="middle" style="font-family:Arial; font-size:.25;width: 75%">
                                            &nbsp;&nbsp;No Results Found!</td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
            <asp:ObjectDataSource ID="Legal_Search" runat="server" SelectMethod="Legal_Search"
                TypeName="IntellectualProperty">
                <SelectParameters>
                    <asp:QueryStringParameter Name="Search" QueryStringField="Search" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>
        </div>
    </form>
</body>
</html>
