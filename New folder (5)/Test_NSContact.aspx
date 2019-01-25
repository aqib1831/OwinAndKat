<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Test_NSContact.aspx.vb" Inherits="Test_NSContact" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
</head>
<body>
    <form id="form1" runat="server">
    <div> 
        <table>
        <tr>
        <td>
        <label id="lblSuccess" runat="server" style="color:green"></label>
        </td>
        <td></td>
        </tr>
        <tr>
        <td>
       <span class="label-container">
                                        <label>
                                            Name *</label></span> 
        </td>
        <td>
        <span class="field-container">
                                                <asp:TextBox ID="txtFullName" runat="server" MaxLength="50"></asp:TextBox></span>
        </td>
        </tr>
        <tr>
        <td>
        
        <span class="label-container">
                                        <label>
                                            Company</label></span> 
        </td>
        <td>
        <span class="field-container">
                                                <asp:TextBox ID="txtCompanyName" runat="server" MaxLength="50"></asp:TextBox></span>
        </td>
        </tr>
        <tr>
        <td>
        <span class="label-container">
                                                <label>
                                                    Country Code*</label></span> 
        </td>
        <td>
        <span class="field-container">
                                                        <asp:TextBox ID="txtCountryCode" runat="server" MaxLength="50"></asp:TextBox></span>

                                                       <%--<asp:DropDownList runat="server" ID="ddlCountry" AutoPostBack="true">
                                                        <asp:ListItem Text="-- Select One --" Value="-1"></asp:ListItem>
                                                         <asp:ListItem Text="US" Value="1"></asp:ListItem>
                                                          <asp:ListItem Text="Canada" Value="2"></asp:ListItem>
                                                        </asp:DropDownList>--%>
                                                 
        </td>
        </tr>
        <tr>
        <td>
        <span class="label-container">
                                                <label>
                                                    State/Province Code *</label></span> 
        </td>
        <td>
        <span class="field-container">
                                                        <%--<asp:DropDownList runat="server" ID="ddlState" AppendDataBoundItems="true">
                                                            <asp:ListItem Text="-- Select One --" Value="-1"></asp:ListItem>
                                                            <asp:ListItem Text="Georgia" Value="1"></asp:ListItem>
                                                            <asp:ListItem Text="New Jersey" Value="2"></asp:ListItem>
                                                        </asp:DropDownList>--%>
                                                       
                                                        <asp:TextBox ID="txtStateCode" MaxLength="40" runat="server" onkeyup="return onKeyUpValidate(event,this);" /></span>
        
        </td>
        </tr>
        <tr>
        <td>
        <span class="label-container">
                                                <label>
                                                    State Name *</label></span> 
        </td>
        <td>
        <span class="field-container">
                                                       
                                                        <asp:TextBox ID="txtState" MaxLength="40" runat="server" onkeyup="return onKeyUpValidate(event,this);" /></span>
        
        </td>
        </tr>
        <tr>
        <td>
        <span class="label-container">
                                        <label>
                                            Zip/Postal Code </label></span>
        </td>
        <td>
         <span class="field-container">
                                                <asp:TextBox ID="txtZipCode" runat="server" MaxLength="5"></asp:TextBox></span>
        </td>
        </tr>
        <tr>
        <td>
        <span class="label-container">
                                        <label>
                                            Phone *</label></span> 
        </td>
        <td>
        <span class="field-container">
                                                <asp:TextBox type="tel" ID="txtPhoneNumber" runat="server" MaxLength="10"></asp:TextBox>
                                            </span>
        </td>
        </tr>
        <tr>
        <td>        <span class="label-container">
                                        <label>
                                            Email Address *</label></span> 
        </td>
       
        <td>
        <span class="field-container">
                                                <asp:TextBox type="email" ID="txtEmailAddress" runat="server" MaxLength="50"></asp:TextBox></span>
        
        </td>
        </tr>
        <tr>
        <td>
        <span class="label-container">
                                        <label>
                                            Best time to call</label></span> 
        </td>       
        <td>
        <span class="field-container">
                                                <asp:TextBox ID="txtBestTimeToCall" runat="server" MaxLength="50" Display="Dynamic"></asp:TextBox></span>
        </td>
         </tr>
        <tr>
        <td>
        <span class="label-container">
                                        <label>
                                            Subject *</label></span> 
        
        </td>
        <td>
        <span class="field-container">
                                                <asp:TextBox ID="txtMessageSubject" runat="server" MaxLength="50"></asp:TextBox></span>
        
        </td>
        </tr>
        <tr>
        <td>
        <span class="label-container">
                                        <label>
                                            Message *</label></span> 
        
        </td>
        <td>
        <span class="field-container">
                                                <asp:TextBox ID="txtFullMessage" runat="server" TextMode="MultiLine" MaxLength="250"></asp:TextBox>
                                            </span>
        </td>
        </tr>
        <tr>
        <td>
        
        </td>
        <td>
       <asp:Button runat="server" Text="Submit" ID="FormSubmit" />              <%-- OnClick="FormSubmit_Click" --%>
        
        </td>
        </tr>
        </table>
    </div>
    </form>
</body>
</html>
