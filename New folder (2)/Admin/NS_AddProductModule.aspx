<%@ Page Language="VB" AutoEventWireup="false" CodeFile="NS_AddProductModule.aspx.vb" Inherits="Admin_NS_AddProductModule" Theme="Default" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Add Product Module</title>
     <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
</head>
<body style ="margin :0px;background-color:#DAF5D6; height:100%; width:100%;" >
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
            <table  cellspacing="0" border="0" style="width:100%;  height:100% ; padding-left: 1em; " class="FormTable"  >
                  <tr>
                     <td  style="height:31px;font-size:13px;font-weight:bold;padding:5px;border-bottom:1px solid #609BD3;">
                      <asp:Label ID="lblHeader" runat="server" Text="Add Module"></asp:Label>
                     </td>
                  </tr>              
                  <tr>
                    <td align="center" style="vertical-align:top; width:100%; height:100%" >                        
                      <div  style="width:100%; height:100%" id="Div1">                        
                        <table border="0" cellpadding="0"  cellspacing="0" class="FormInnerTable" style="width:100%; height:100% ; text-align:left; vertical-align:top; padding-left:1em;"  >
                                    <tr>
                                        <td style="width: 9%; text-align: left; height: 10px;">
                                        </td>
                                        <td align="center" colspan="3">
                                            <asp:Label ID="lblMessage" runat="server" CssClass="Requiredfield" Text="Module already exists"
                                                Visible="False"></asp:Label></td>
                                        <td style="width: 15%; text-align: left;">
                                        </td>
                                     </tr>
                                    <tr>
                                        <td style="text-align: left; height: 18px; padding-left: 20px;" valign="top"  >
                                            Title:<span class="RequiredField" style="font-size: 9pt; color: #000000"><span
                                                style="font-size: 8pt; color: #ff0000">*</span></span>
                                        </td>
                                        <td style="text-align: left; padding-right: 20px; padding-left: 2px;" valign="top" colspan="4">
                                            <asp:TextBox ID="txtTitle" runat="server" 
                                                MaxLength="100" 
                                                SkinID="GreenSmallTextbox"
                                                Width="100%"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RFV_Title" runat="server" 
                                                ControlToValidate="txtTitle"
                                                Display="Dynamic" 
                                                ErrorMessage="Please Enter Title" 
                                                SkinID="RequiredFieldValidation"></asp:RequiredFieldValidator></td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: left; padding-left: 20px; height: 18px;" valign="top">
                                            Abbreviation:<span style="color: #000000"><span style="color: #ff0000">*</span></span>
                                        </td>
                                        <td style="padding-left: 2px;" valign="top">
                                            <asp:TextBox ID="txtAbbreviation" runat="server" 
                                                MaxLength="20" SkinID="GreenSmallTextbox"
                                                Width="150px"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RFV_Abbreviation" runat="server" 
                                                ControlToValidate="txtAbbreviation"
                                                Display="Dynamic" 
                                                ErrorMessage="Please Enter Abbreviation" 
                                                SkinID="RequiredFieldValidation"></asp:RequiredFieldValidator>
                                                </td>
                                        <td style="text-align: left" valign="top">
                                        </td>
                                        <td style=" text-align: left; padding-left:0px;" valign="top">
                                            Price:<span style="color: #ff0000; padding-left: 0px;">*</span></td>
                                        <td style="text-align: left; padding-right: 20px; padding-left: 0px;" valign="top">
                                            <asp:TextBox ID="txtPrice" runat="server" MaxLength="10" SkinID="GreenSmallTextbox"
                                                 Width="150px" ></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RFV_txtPrice" runat="server" ControlToValidate="txtPrice"
                                                Display="Dynamic" ErrorMessage="Please Enter Price" SkinID="RequiredFieldValidation"></asp:RequiredFieldValidator>
                                            <asp:CompareValidator ID="CMPVAL_txtPrice" runat="server" ControlToValidate="txtPrice"
                                                Display="Dynamic" ErrorMessage="Enter Valid Price" Type="Double" Operator="DataTypeCheck"></asp:CompareValidator></td>
                                    </tr>
                                    <tr style="font-size: 9pt">
                                        <td style="text-align: left; padding-left: 20px; height:18px;" valign="top">
                                        Type:<span style="color: #ff0000">*</span>
                                        </td>
                                        <td valign="top" align="left" style="padding-left: 2px">
                                            <asp:DropDownList ID="ddlType" runat="server" CssClass="SimpleExSmall" Width="150px">
                                                    <asp:ListItem Value="0">Select...</asp:ListItem>
                                                    <asp:ListItem Value="2">Hardware</asp:ListItem>
                                                    <asp:ListItem Value="1">Software</asp:ListItem>
                                                    <asp:ListItem Value="3">Services</asp:ListItem>
						    <asp:ListItem Value="4">Support</asp:ListItem>
                                                </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RFV_ddlType" runat="server" ControlToValidate="ddlType"
                                                Display="Dynamic" ErrorMessage="Please Select Type" SkinID="RequiredFieldValidation" InitialValue="0"></asp:RequiredFieldValidator></td>
                                        <td style="text-align: left; " valign="top">
                                        </td>
                                        <td style="text-align: left; padding-left: 0px;" valign="top">
                                        Price&nbsp;Option:<span style="color: #ff0000">*&nbsp; </span>&nbsp;</td>
                                        <td style="text-align: left; padding-right: 20px; padding-left: 0px;" valign="top">
                                            <asp:DropDownList ID="ddlPriceOption" runat="server" CssClass="SimpleExSmall" Width="150px">
                                            <asp:ListItem Value="0">Select...</asp:ListItem>
                                            <asp:ListItem Value="1">Per Lincense</asp:ListItem>
                                            <asp:ListItem Value="2">Per Month</asp:ListItem>
                                        </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlPriceOption"
                                                Display="Dynamic" ErrorMessage="Please Select Price Option" InitialValue="0"
                                                SkinID="RequiredFieldValidation"></asp:RequiredFieldValidator></td>
                                    </tr>
                                    <tr style="font-size: 9pt;">
                                <td style="padding-left: 20px; height: 18px; text-align: left" valign="top">
                                    &nbsp;Sub&nbsp;Module&nbsp;Of:</td>
                                <td align="left" style="padding-left: 2px" valign="top">
                                    <asp:DropDownList ID="ddlProduct" runat="server"
                                     CssClass="SimpleExSmall" Width="150px"
                                     DataSourceID="sdsProducts" DataTextField="Title" DataValueField="ID"    >
                                    </asp:DropDownList> <asp:SqlDataSource ID="sdsProducts" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                        ProviderName="<%$ ConnectionStrings:PortalConnectionString.ProviderName %>" SelectCommand="NS_GetAllProducts">
                                    </asp:SqlDataSource>
                                </td>
                                <td style="text-align: left" valign="top">
                                </td>
                                <td style="padding-left: 0px; text-align: left" valign="top">
                                </td>
                                <td style="padding-right: 20px; padding-left: 0px; text-align: left" valign="top">
                                </td>
                                </tr> 
                                    <tr>
                                        <td align="center" colspan="7" style="height:10px;" valign="bottom">
                                            Fields marked with an asterisk 
                                            <span class="RequiredField" style="color: #000000">
                                                <span style="color: #ff0000">*</span>
                                            </span> are required.
                                        </td>
                                    </tr>                                                                           
                         </table>
                      </div>                                                        
                    </td>
                  </tr>
                  <tr>               
                    <td align="center"  style="height:31px; border-top:1px solid #609BD3; vertical-align:middle;">
                        <asp:Button ID="btnSave" 
                            runat="server" 
                             Text="Save" 
                            CssClass="Btn3D" 
                            Width="80px" 
                            CommandName="Insert" />&nbsp;&nbsp;
                            <asp:Button ID="btnCancel" 
                            runat="server" 
                             Text="Cancel" 
                            CssClass="Btn3D" 
                            Width="80px" 
                            CommandName="Insert" />
                   </td>
              </tr>                              
         </table>  
         <asp:HiddenField ID="hdnProductID" runat="server" />  
          <asp:HiddenField ID="hdnModuleID" runat="server" />  
    </div>
    </form>
</body>
</html>
