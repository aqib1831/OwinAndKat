<%@ Page Language="VB" AutoEventWireup="false" CodeFile="WeeklyLetter_Print.aspx.vb" Inherits="admin_comm_WeeklyLetter_Print" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>EAI Weekly Letter</title>
        <script type="text/javascript" defer="true" >
  function Body_OnLoad()
    {
    try
         {
        window.focus();
        factory.printing.header = "&w&bPage &p of &P"
        factory.printing.footer = "";
        factory.printing.leftMargin = 0.20;
        factory.printing.rightMargin = 0.20;
        factory.printing.topMargin = 0.80;
        factory.printing.bottomMargin = 0.80;
        SetImageWidth();
        //factory.printing.Print(true);
        }
         catch(err)
         {}
    }

    function SetImageWidth() 
    {
        
        var images = document.images;
        for (var i = 0;i<images.length;i++)
        {
                if(parseInt(images[i].width) > 640)
                    images[i].width = 640;
        }
    
    }

</script>

</head>
<body onload="Body_OnLoad();try{parent.frameWeeklyLetter.focus();parent.frameWeeklyLetter.print();}catch(ex){}">
<object id="factory" style="display:none;" classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814" codebase="../../ScriptX/ScriptX.cab#Version=6,2,433,9"></object>
    <form id="frmWeeklyLetterPrint" runat="server">
    <div>

        <table align="center" width="640" height="100%" border="0" cellpadding="0" cellspacing="0" >
        <tr valign="top">
		<td align="center" height="85">
		    <asp:FormView ID="frmViewWeeklyLetter" runat="server" DataSourceID="srcWeeklyLetter" Width="100%" Height="85" BorderWidth="0" CellPadding="0" CellSpacing="0">
		    <ItemTemplate>
                <font size="3">
                    <asp:HiddenField ID="hdnStatus" runat="server" Value='<%# Bind("IsPublished") %>' />
                    <asp:HiddenField ID="hdnLetterID" runat="server" Value='<%# Bind("ID") %>' />
                    <asp:literal ID="ltlFromDate" Visible="false" runat="server" Text='<%# Eval("FromDate", "{0:m}") %>'></asp:literal>
                    <asp:literal ID="ltlToDate" Visible="false" runat="server" Text='<%# Eval("ToDate", "{0:m}") %>'></asp:literal> 
                    <asp:literal ID="ltlDate" Visible="false" runat="server" Text='<%# Year(Eval("ToDate")) %>'></asp:literal>
                </font></font></div></td>
		    <tr>
			    <td width="150"><img src="https://qa.netsolace.com/images/logo_netsolace.gif" /></td>
			    <td ><div align="right"><font size="4" face="Arial, Helvetica, sans-serif"><strong><%#Eval("Title")%></strong><br>
                </div>
                </td></tr>
		    </ItemTemplate>
		    </asp:FormView>
                <asp:ObjectDataSource
                id="srcWeeklyLetter"
                TypeName="Portal.BLL.Communication.WeeklyLetter"
                SelectMethod="GetWeeklyLetter_ByID"
                Runat="server">
                <SelectParameters>
                    <asp:QueryStringParameter DefaultValue="1" Name="ID" QueryStringField="LetterID" Type="int32" />
                </SelectParameters>
                </asp:ObjectDataSource>
		   </td>
        </tr>

        <tr valign="top">
          <td height="2" bgcolor="#666666"><img src="../images/spacer.gif" width="1" height="1" /></td>
        </tr>

        <tr id="trForumHeadline1" runat="server">
          <td height="100">
           <table width="100%" height="70" border="0" align="center" cellpadding="10" cellspacing="0">
            <tr>
              <td>
              <asp:FormView ID="FormView1" runat="server" DataSourceID="srcFranchiseForums" Width="100%">
                <ItemTemplate>
                    <font size="4" face="Arial, Helvetica, sans-serif">Forum</font>
                    <font size="4" face="Arial, Helvetica, sans-serif"> <br />
                    &quot;<asp:literal ID="ltlHeadline" runat="server" Text='<%# Bind("HeadLine") %>'></asp:literal>&quot;<br />
                    <font size="2">
                        <asp:Literal ID="ltlSmallDescription" runat="server" Text='<%# Bind("SmallDescription") %>' ></asp:Literal>
                    </ItemTemplate>
	                <EmptyDataTemplate>
    	                <center><font color="#000000" face="Arial, Helvetica, sans-serif">No Forum Defined!</font> &nbsp;</center> 
	                </EmptyDataTemplate>
                </asp:FormView>
               <asp:ObjectDataSource
                id="srcFranchiseForums"
                TypeName="Portal.BLL.Communication.WeeklyLetter"
                SelectMethod="GetWeeklyLetterNews_ByLetterID"
                Runat="server">
                <SelectParameters>
                    <asp:QueryStringParameter DefaultValue="1" Name="LetterID" QueryStringField="LetterID" Type="int32" />
                    <asp:Parameter DefaultValue="2" Name="Type" Type="int32" />
                </SelectParameters>
                </asp:ObjectDataSource>
                </td>
              </tr>
          </table>
         </td>
       </tr>

        <tr id="trForumHeadline2" runat="server">
          <td height="1" bgcolor="#666666"><img src="../images/spacer.gif" width="1" height="1" /></td>
        </tr>
        <tr>
            <td height="15"><img src="../images/spacer.gif" width="1" height="1"></td>
        </tr>

        <tr>
           <td height="40">
            <table width="100%" height="70" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td><a name="top" id="top"></a><font size="5" face="Arial, Helvetica, sans-serif">Headlines</font>
                    <asp:Repeater
                    id="rptNewsHeadlines"
                    DataSourceID="srcNews"
                    Runat="server">
                        <HeaderTemplate>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        </HeaderTemplate>
                        <ItemTemplate>
                           <tr>
                              <td width="100%" height="31"><li><b><font face="Arial, Helvetica, sans-serif"><%#Eval("HeadLine")%></font></b></li></td>
                           </tr>
                           <tr>
                              <td width="100%" height="31"><font face="Arial, Helvetica, sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;<%#Eval("SmallDescription")%></font></td>
                           </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </table>                    
                        </FooterTemplate>
                    </asp:Repeater>
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
                    <asp:Literal ID="ltlHeadlinesNoRecord" runat="server" Visible="false" Text="<center><font color='#000000' face='Arial, Helvetica, sans-serif'>No Headlines Defined!</font> &nbsp; </center> "></asp:Literal>
                </td>
              </tr>
            </table>
          </td>
        </tr>

        <tr>
            <td height="10"><img src="../images/spacer.gif" width="1" height="1"></td>
        </tr>

        <tr valign="top">
		  <td >
             <asp:Repeater
                id="rptNewsDetail"
                DataSourceID="srcNews"
                Runat="server">
                   <ItemTemplate>
    		          <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" >
                        <tr>
                          <td>
                           <table width="100%" border="0" cellpadding="5" cellspacing="0">
                              <tr >
                                <td height="30" style="border-bottom:solid 1px #666666;">
                                    <font face="Arial, Helvetica, sans-serif"><strong><asp:literal ID="ltlNewsSmallDescription" runat="server" Text='<%# Bind("HeadLine") %>'></asp:literal></strong></font>
                                </td>
                              </tr>
                              <tr>
                                <td width="97%" height="75" valign="top" style="border-bottom:solid 1px #666666;"><font size="2" face="Arial, Helvetica, sans-serif"><asp:literal ID="ltlNewsDescription" runat="server" Text='<%# Bind("Description") %>'></asp:literal></font></td>
                              </tr>
                           </table>
                         </td>
                        </tr>
                        <tr>
                            <td height="30"><img src="../images/spacer.gif" width="1" height="1"></td>
                        </tr>
                      </table>
                    </ItemTemplate>
                    <FooterTemplate>
                    </FooterTemplate>
                </asp:Repeater>        
                
		        <table width="100%" height="70" border="0" align="center" cellpadding="0" cellspacing="0" id="tblFranchiseForum" runat="server">
                    <tr>
                      <td>
                      <table width="100%" border="0" cellpadding="2" cellspacing="0">
                          <tr>
                            <td width="97%" height="30">
                                <p><font face="Arial, Helvetica, sans-serif"> &nbsp;<br />
                                    <strong><img src="https://www.fransupport.com/images/ico_forum.gif" width="48" height="40" align="absmiddle" /></strong><font size="5">Forum</font></font><br />&nbsp;
                                </p>
                            </td>
                          </tr>
                          <tr>
                            <td>
                                <asp:FormView ID="FormView2" runat="server" DataSourceID="srcFranchiseForums" Width="100%">
                                    <ItemTemplate>
                                        <asp:Literal ID="ltlDescription" runat="server" Text='<%# Bind("Description") %>'></asp:Literal>  
                                    </ItemTemplate>
                                    <EmptyDataTemplate>
                                         <center><font face="Arial, Helvetica, sans-serif">No Forum Defined!</font> &nbsp;</center> 
                                    </EmptyDataTemplate>  
                                </asp:FormView>
                             </td>
                          </tr>
                      </table>
                     </td>
                    </tr>
                  </table>
	          <%--<hr />--%>
	          <p align="center"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">&copy; <%= Year(Now()) %>, Netsolace, Inc. </font><br />
              &nbsp;</p>
            </td>		
        </tr>

        <tr>
            <td>&nbsp;</td>
        </tr>

        </table>    
    </div>
    </form>
</body>
</html>
