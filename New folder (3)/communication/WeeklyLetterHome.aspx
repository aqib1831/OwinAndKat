<%@ Page Language="VB" AutoEventWireup="false" CodeFile="WeeklyLetterHome.aspx.vb" EnableTheming="true" Theme="Default" Inherits="Communication_WeeklyLetterHome"  %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
   <title>Netsolace Portal News</title>
    <meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.Fade(duration=.1)" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <style type="text/css">
    .BtnPurple
    {
    border:1px solid #3A5684;
    font-family:Verdana;
    letter-spacing:-1px;
    word-spacing:1px;
    text-transform:uppercase;
    font-size:10px;
    font-weight:bold;
    color:#000000;
    background-color:#A3B7D7;
    height:20px;
    }
    </style>
</head>
<body style="background-color:#E4F2F5;height:100%;padding:0;margin:0;" scroll="no">
    <form id="frmPassword" runat="server">
    <table border="0" cellpadding="0" cellspacing="0" style="height:100%;" width="100%">
            <tr>
                <td style="height:100%;padding:0px;">
                       <asp:Repeater  
                            runat="server"
                            ID="fvNews"
                            DataSourceID="sdsNews">
                            <ItemTemplate>
                                 <iframe name="IfNews" runat="server" id="IfNews" src="WeeklyLetterHomeContent.aspx" width="100%" height="100%" frameborder="0"  ></iframe>
                                 <asp:HiddenField id="lblWeeklyLetterID" runat="server" Value='<%#Eval("ID") %>' ></asp:HiddenField>
                            </ItemTemplate>
                            </asp:Repeater>
                           <asp:ObjectDataSource ID="sdsNews" runat="server"
                                SelectMethod="WeeeklyLettersGetByUserID"
                                TypeName="Portal.BLL.Communication.WeeklyLetter">  
                           <SelectParameters>
                              <asp:SessionParameter  Name="UserID" Type="Int32" SessionField="AdminID" />
                           </SelectParameters>                                          
                        </asp:ObjectDataSource>
                 </td>
            </tr>
            <tr>
                <td style="height:28px;">
                    <div style="height:28px;background-color:#486BA3;text-align:center;vertical-align:middle;padding:3 0 3 0;" > 
                       <asp:Button ID="btnContinue" runat="server" Text="Continue" CssClass="BtnPurple" UseSubmitBehavior="true" CausesValidation="false"  />
                    </div>
                </td>
            </tr>
    </table>
    <script type="text/javascript" language="javascript">

    </script>
    </form>
</body>
</html>