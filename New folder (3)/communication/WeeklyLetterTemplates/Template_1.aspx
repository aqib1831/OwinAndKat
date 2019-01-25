<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Template_1.aspx.vb" Inherits="admin_comm_WeeklyLetterTemplates_Template_2" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Weekly Letter</title>
    
</head>
<body leftmargin="0" topmargin="0" bottommargin="0" rightmargin="0" oncontextmenu="return false;" onselectstart="return false;">
    <form id="form1" runat="server">
    <div>

<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#F3F7BE">
<tr>
		<td align="center">
		<table width="760" height="85" border="0" cellpadding="0" cellspacing="0">
		<tr>
    		<td width="150"><img src="https://qa.netsolace.com/images/logo_netsolace.gif" /></td>
			<td ><div align="right"><font size="5" face="Arial, Helvetica, sans-serif"><strong><asp:Literal ID="ltlTitle" runat="server"></asp:Literal></strong><br>
		    <asp:FormView ID="frmViewWeeklyLetter" runat="server" DataSourceID="srcWeeklyLetter" EnableViewState="false">
		        <ItemTemplate>
	                <font size="3">
	                    <asp:HiddenField ID="hdnStatus" runat="server" Value='<%# Bind("IsPublished") %>' />
	                    <asp:HiddenField ID="hdnLetterID" runat="server" Value='<%# Bind("ID") %>' />
	                    <asp:HiddenField ID="hdnLetterTitle" runat="server" Value='<%# Bind("Title") %>' />
	                    <asp:literal ID="ltlFromDate" runat="server" Text='<%# Eval("FromDate", "{0:m}") %>'></asp:literal>&nbsp;-&nbsp;
	                    <asp:literal ID="ltlToDate" runat="server" Text='<%# Eval("ToDate", "{0:m}") %>'></asp:literal>, 
	                    <asp:literal ID="ltlDate" runat="server" Text='<%# Year(Eval("ToDate")) %>'></asp:literal>
	                </font></font></div></td>		    
		        </ItemTemplate>
		    </asp:FormView>

		</tr>
		</table></td>
</tr>
<tr>
  <td height="1" bgcolor="#667C29"><img src="../../images/spacer.gif" width="1" height="1" /></td>
</tr>
<tr>
		<td height="40" style="padding-top:5px;" ><table width="760" height="70" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td><a name="top" id="top"></a><font size="5" face="Arial, Helvetica, sans-serif">Headlines</font>
                <asp:Repeater
                id="rptNewsHeadlines"
                DataSourceID="srcNews"
                EnableViewState="false"
                Runat="server">
                    <HeaderTemplate>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    </HeaderTemplate>
                    <ItemTemplate>
                       <tr>
                          <td width="3%" height="31"><img src="https://www.fransupport.com/images/ico_bullet.gif " width="16" height="16" /></td>
                          <td width="97%" height="31"><a href='#<%#Eval("ID")%>'><font face="Arial, Helvetica, sans-serif"><%#Eval("HeadLine")%></font></a></td>
                       </tr>
                       <tr>
                          <td>&nbsp;</td>
                          <td style="font-size:14px; padding-left:5px;"><%#Eval("SmallDescription")%></td>
                       </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>                    
                    </FooterTemplate>
                </asp:Repeater>
                
                <asp:Literal ID="ltlHeadlinesNoRecord" runat="server" Visible="false" Text="<center><font color='#000000' face='Arial, Helvetica, sans-serif'>No Headlines Defined!</font> &nbsp; <!--<a href='WeeklyLetter_Add.aspx'><font size='2' face='Arial, Helvetica, sans-serif'><strong>Add New</strong></font></a>--></center> "></asp:Literal>
                
            </td>
          </tr>
        </table>
		  </td>
</tr>

<tr>
		<td height="30"><img src="../../images/spacer.gif" width="1" height="1"></td>
</tr>
<tr>
		<td >
		
          <asp:Repeater
                id="rptNewsDetail"
                EnableViewState="false"
                DataSourceID="srcNews"
                Runat="server">
                    <ItemTemplate>
            		  <table width="760" height="70" border="0" align="center" cellpadding="0" cellspacing="0" >
                        <tr>
                          <td><table width="100%" border="1" cellpadding="2" cellspacing="0" bordercolor="#829E34" style="border-collapse:collapse;">
                              <tr>
                                <td height="30" bgcolor="#BFD683"><font color="#000000" face="Arial, Helvetica, sans-serif"><a name='#<%#Eval("ID")%>' id='#<%#Eval("ID")%>'></a><strong><asp:literal ID="ltlNewsSmallDescription" runat="server" Text='<%# Bind("HeadLine") %>'></asp:literal></strong></font>
                                    <font size="2" face="Arial, Helvetica, sans-serif"><asp:Literal ID="ltlEditNewsLink" runat="server"></asp:Literal></font>
                                </td>
                              </tr>
                              <tr>
                                <td width="97%" height="75" bordercolor="#F3F7BE" valign="top"><font size="2" face="Arial, Helvetica, sans-serif"><asp:literal ID="ltlNewsDescription" runat="server" Text='<%# Bind("Description") %>'></asp:literal></font></td>
                              </tr>
                              <tr>
                                <td bordercolor="#F3F7BE"><div align="right"><a href="#top"><font size="2" face="Arial, Helvetica, sans-serif"><strong>Return to Top</strong></font></a></div></td>
                              </tr>
                          </table></td>
                        </tr>
                      </table><br />
                    </ItemTemplate>
                    <FooterTemplate>
                    
                    </FooterTemplate>
                </asp:Repeater> 

		  <hr />
		  <p align="center"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">&copy; <%= Year(Now()) %>, Netsolace Weekly Newsletter. </font><br />
	      &nbsp;</p>
   
    </td>		
</tr>
</table>
    
    </div>
    
        <asp:ObjectDataSource
        id="srcWeeklyLetter"
        TypeName="Portal.BLL.Communication.WeeklyLetter"
        SelectMethod="GetWeeklyLetter_ByID"
        Runat="server">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="1" Name="ID" QueryStringField="LetterID" Type="int32" />
        </SelectParameters>
        </asp:ObjectDataSource>

        <asp:ObjectDataSource
        id="srcNews"
        TypeName="Portal.BLL.Communication.WeeklyLetter"
        SelectMethod="GetWeeklyLetterNews_ByLetterID"
        Runat="server">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="1" Name="LetterID" QueryStringField="LetterID" Type="int32" />
            <asp:Parameter DefaultValue="1" Name="Type" Type="int32" />
        </SelectParameters>
        </asp:ObjectDataSource>

    </form>
</body>
</html>