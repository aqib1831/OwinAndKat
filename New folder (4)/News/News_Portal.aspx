<%@ Page Language="VB" AutoEventWireup="false" CodeFile="News_Portal.aspx.vb" EnableTheming="true" Theme="Default" Inherits="News_News_Portal"  %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
   <title>Netsolace Portal News</title>
    <meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.Fade(duration=.1)" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
</head>
<body style="background-color:#E4F2F5;height:100%;overflow:auto;padding:0;margin:0;">
    <form id="frmPassword" runat="server">
    <table border="0" cellpadding="0" cellspacing="0" style="height:100%;" width="100%">
            <tr>
                <td style="height:100%;padding:4px;">
                                           <asp:FormView 
                                                runat="server"
                                                ID="fvNews"
                                                Width="100%"
                                                Height="100%"
                                                DataSourceID="sdsNews"
                                                CellPadding="0"
                                                CellSpacing="0">
                                                <ItemTemplate>
                                                <div style="height:40px;background-color:#A0CDEE;vertical-align:middle;border-bottom:solid 3px #E4F2F5;padding-top:9px;" ><span style="float:right;position:relative;padding:0 8 0 0;"><%#CDate(Eval("Date")).ToString("dddd, MMMM dd, yyyy")%></span>&nbsp;<b> <%# Eval("HeadLine") %></b>&nbsp;</div>
                                                <div style="height:92%;border:1px solid #7DA4CD;background-color:#BADCFC;text-align:center;vertical-align:middle;padding:0px;">
                                                     <iframe name="IfNews" runat="server" id="IfNews" src="NewsContent.aspx" style="margin: 0px;width:100%;height:100%;border:0px" scrolling="no" frameborder="0"></iframe>
                                                     <asp:HiddenField id="lblNewsID" runat="server" Value='<%#Eval("ID") %>' ></asp:HiddenField>
                                                 </div>
                                                </ItemTemplate>
                                                </asp:FormView>
                                              <asp:ObjectDataSource ID="sdsNews" runat="server"
                                                    SelectMethod="NewsGetByUserID"
                                                    TypeName="Portal.BLL.News.News">  
                                               <SelectParameters>
                                                  <asp:SessionParameter  Name="UserID" Type="Int32" SessionField="AdminID" />
                                               </SelectParameters>                                          
                                            </asp:ObjectDataSource>
                 </td>
            </tr>
            <tr>
                <td style="height:28px;">
                    <div style="height:28px;background-color:#A0CDEE;text-align:center;vertical-align:middle;padding:3 0 3 0;" > 
                            <asp:Button ID="btnContinue" runat="server" Text="Continue" CssClass="Btn3D" UseSubmitBehavior="true" CausesValidation="false"  />
                     </div>
                </td>
            </tr>
    </table>
    <script type="text/javascript" language="javascript">

    </script>
    </form>
</body>
</html>