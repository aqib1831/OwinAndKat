<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MailContacts.aspx.vb" Inherits="FranMail_MailContacts" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Contacts</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js" ></script>
    <style type="text/css">
    .RowBorder TD
        {
            border-bottom:1px solid #D0ECED;
        }

    </style>
</head>
<body style="margin:0px; overflow:auto;">
    <form id="form1" runat="server">

    <table  border="0" cellspacing="0" cellpadding="0" style="width:100%;height:100%;">
      <tr style="height:35px;">
        <td colspan="6">
          <table  border="0" cellspacing="0" cellpadding="0" style="font-size:11px;width:100%;height:100%;">
                <tr style="height:20px;">
                  <td  style="background-color:#BADBFC;font-size:10px;padding-left:2px;padding-top:5px;">Add New Contact:</td>
                </tr>                                       
                <tr style="height:25px;">
                    <td   style=" background-color:#BADBFC; width:65%;border-bottom:1px solid #88C4FA;padding-left:2px; height: 25px;">                                               
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnAdd">
                       <asp:TextBox runat="server" ID="txtEmail" CssClass="GreyTextBox" style="Font-Size:11px; height:20px; width:150px;" MaxLength="200" />
                       <asp:Button ID="btnAdd" runat="server" Text="Insert" CssClass="Btn3D" Height="20" Width="60" />
                       <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtEmail" Display="Dynamic"
                                ErrorMessage="<br>Please Enter Email"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="REG_txtCorporateEmail" ControlToValidate="txtEmail" ErrorMessage="<br>Please enter valid email"
                                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic" runat="Server" />
                        <asp:Label ID="lblError" runat="server" CssClass="SimpleSmall" ForeColor="red"></asp:Label>
                       </asp:Panel>
                    </td>
                </tr>
          </table>	    
        </td>
      </tr>
      <tr style="width:100%; background-color:#FFFFFF;">
            <td style="width:100%;background-color:#FFFFFF;" colspan="6">                                  
                        <asp:Repeater
                            runat="server"
                            ID="rptEmails"
                            DataSourceID="sdsEmails" >
                            <HeaderTemplate>
                                <table border="0" cellpadding="0" cellspacing="0" style="height:100%; width:100%; font-size:11px;">
                                    <tr>
                                        <td style="width:3%;height:22px;background-color:#BADBFC;">&nbsp;</td>
                                        <td style="background-color:#BADBFC;color:#4D728F;"><img  align="absmiddle" src="../images/spacer.gif" /><b>&nbsp;Email Contacts</b></td>
                                        <td style="width:3%;background-color:#BADBFC;color:#4D728F;">Delete&nbsp;</td>
                                    </tr>
                                    <tr>
                                      <td colspan="3">
                                        <div id="Div1" style="overflow-y:auto;Height:100%;Width:100%;" class="ScrollBarHomeTicket">
                                            <table border="0" cellpadding="0" cellspacing="0" style="height:100%; width:100%; font-size:11px;">
                            </HeaderTemplate>
                            <ItemTemplate>
                                    <tr style="background-color:#FFFFFF; cursor:pointer;" class="RowBorder" onmouseover="ColorOn(this);" onmouseout="ColorOff(this);">
                                        <td style="width:3%;height:22px;" >&nbsp;<img src="../images/arrows.gif" align="absmiddle" /></td>
                                        <td>&nbsp;<span title="<%#Eval("Email")%>"><%#Eval("Email")%></span></td>
                                        <td style="width:3%;"><img align="absmiddle" src="../images/delete.gif" onclick="window.location='MailContacts.aspx?ID=<%#Eval("ID")%>';" title="Delete" />&nbsp;
                                    </td>
                                    </tr>                                                                                                                                             
                            </ItemTemplate>
                            <FooterTemplate>
                                    <tr>
                                        <td colspan="3">
                                        </td>
                                    </tr>                                                       
                                   </table>
                                </div>
                                </td>
                              </tr>
                             </table>
                            </FooterTemplate>
                        </asp:Repeater>
                        
                        <asp:SqlDataSource ID="sdsEmails" 
                        runat="server" 
                        SelectCommandType="StoredProcedure" 
                        SelectCommand="FranMail_Emails_GetAll" 
                        ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>" 
                        />
            </td>
        </tr>                            
    </table>
    </form>
</body>
</html>

<script type="text/javascript">
    function ColorOn(blah)
    {
        blah.style.backgroundColor='#EFF7FF';
    }
    function ColorOff(blah)
    {	   
        blah.style.backgroundColor='#FFFFFF';
    }
</script> 
    