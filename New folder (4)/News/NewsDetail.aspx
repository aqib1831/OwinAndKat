<%@ Page Language="VB" AutoEventWireup="false" CodeFile="NewsDetail.aspx.vb" Inherits="News_NewsDetail" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>News Detail</title>
</head>
<body style="width:100%; height:100%;padding:0px;">
    <form id="form1" runat="server">   
        <asp:HiddenField runat="server" ID="hdnNewsID" Value="0" />
        <asp:HiddenField runat="server" ID="hdnClientID" Value="0" />
        <table style="width:100%;height:100%;"  border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td> 
                     <asp:FormView 
                            runat="server"
                            ID="fvNews"
                            Width="100%"
                            Height="100%"
                            DataSourceID="sdsNews"
                            CellPadding="0"
                            CellSpacing="0"  >
                            <ItemTemplate>
                                 <div style="height:40px;background-color:#A0CDEE;vertical-align:middle;padding-top:9px;" ><span style="float:right;position:relative;padding:0 8 0 0;"><%#CDate(Eval("Date")).ToString("dddd, MMMM dd, yyyy")%></span>&nbsp;<b> <%# Eval("HeadLine") %></b>&nbsp;</div>                               
                                 <div style="width:100%; height:91%;overflow-y:auto; padding:0px;" >
                                 <table style="width:100%;height:100%;"  border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                      <td valign="top" class="SimpleLabel">
      	                                 <%# Eval("News") %>
                                      </td>
                                    </tr>
                                </table>
                                </div>                               
                            </ItemTemplate>
                            </asp:FormView>
                      <asp:ObjectDataSource ID="sdsNews" runat="server"
                            OldValuesParameterFormatString="original_{0}"                                            
                            SelectMethod="NewsGetByID"
                            TypeName="Portal.BLL.News.News">  
                       <SelectParameters>
                          <asp:ControlParameter  Name="NewsID" Type="Int32" ControlID="hdnNewsID" PropertyName="Value" />                      
                       </SelectParameters>                                          
                    </asp:ObjectDataSource>
                </td>
            </tr>        
        </table>
    
    </form>
</body>
</html>
