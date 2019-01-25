<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Skip_Synchronization.aspx.vb" Inherits="com_Skip_Synchronization" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Skip Synchronization</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
</head>
<body style="margin:0px;width:100%;height:100%;background-color:#DDE4EE;padding:0px;border:0px;" onload="document.getElementById('<%=  txtSkipRequestKey.ClientID%>').focus();">
 <form id="form1" runat="server">
 <asp:HiddenField ID="hdnFranchiseID" runat="server" />
 <asp:HiddenField ID="hdnFranchiseContactID" runat="server" />
   
    <div>
        <table style="width:100%;height:100%;background-color:#FFFFFF;; border:1 solid #609BD3; padding:0px;" class="Table"   border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
               <td style="height:100px;">   
                  <table style="width:100%;height:100%; border-color:#7391B9;"  border="0" align="center" cellpadding="0" cellspacing="0" class="Table"  >
                      <tr style="background-color:#DDE4EE;">
                            <td style="height:31px;" colspan="13">	
                               <table cellpadding="0" cellspacing="0" width="100%" border="0">
                                    <tr>
                                        <td  class="SimpleBold" style="height:31px;background-color:#BDE7BD;color:#000000;border-bottom:1 solid #609BD3; width:58%; ">
                                            &nbsp;
                                            <asp:Label ID="lblTitle" runat="server" Text="Generate Synchronization Skip Key" ></asp:Label>
                                        </td>                                          
                                    </tr>
                               </table>
                            </td>
                       </tr>
                     <tr style="border-color:#F5F5F5; background-color:#DEF7D6;">
                            <td style="width:2%;"></td>
                            <td style="width:10%;"></td>
                            <td style="width:1%;"></td>
                            <td style="width:20%;" ></td>
                            <td style="width:1%;"></td>
                            <td style="width:0%;"></td>
                            <td style="width:1%;"></td>
                            <td style="width:00%;"></td>
                            <td style="width:1%;"></td>
                            <td style="width:00%;"></td>
                            <td style="width:1%;"></td>
                            <td style="width:00%;"></td>
                            <td style="width:2%;"></td>
                      </tr>
                      <tr > 
                            <td height="1"  colspan="13"><img  src="../../images/spacer.gif" width="1" height="1" alt="" /></td>
                      </tr>
                      <tr style="border-color:#F5F5F5; background-color:#DEF7D6;">
                            <td  style="height:25px;"></td>
                            <td align="right" colspan="2"  class="tablefont">Store #:<span class="RequiredField">*</span></td>
                            <td align="center" >
                                <asp:TextBox ID="txtStoreNumber" ReadOnly="true" 
                                    runat="server" 
                                    MaxLength="4" 
                                    SkinID="GreenSmallTextbox"
                                    Width="80">
                                </asp:TextBox>
                                <%--<asp:RequiredFieldValidator ID="RFV_txtStoreNumber" 
                                    runat="server" 
                                    ControlToValidate="txtStoreNumber"
                                    Display="Dynamic" 
                                    ErrorMessage="<br>Please enter store number" 
                                    SkinID="RequiredFieldValidation">
                               </asp:RequiredFieldValidator>
                               <asp:RangeValidator
                                  ID="RE_txtStoreNumber"
                                  ControlToValidate="txtSkipRequestKey"
                                  Display="Dynamic" 
                                  MaximumValue="9999" 
                                  MinimumValue="0"
                                  Text="<br>Please enter valid store number"
                                  Type="Integer"
                                  Runat="Server" 
                                  SkinID="RequiredFieldValidation">
                               </asp:RangeValidator>
                                --%>
                            </td>
                            <td ></td>
                            <td  class="tablefont"></td>
                            <td ></td>
                            <td >
                                
                            </td>
                            <td ></td>
                            <td  class="tablefont"></td>
                            <td ></td>
                            <td >
                            </td>
                            <td ></td>
                      </tr>
                      <tr > 
                            <td height="1"  colspan="13"><img  src="../../images/spacer.gif" width="1" height="1" alt="" /></td>
                      </tr>
                      <tr style="border-color:#F5F5F5; background-color:#DEF7D6;">
                            <td ></td>
                            <td colspan="2" align="right"  class="tablefont">Skip Request Key:<span class="RequiredField">*</span></td>
                            <td align="center" >
                                <asp:TextBox ID="txtSkipRequestKey" CssClass="TextBoxBlueBorderPin" 
                                    runat="server" 
                                    MaxLength="4" 
                                    SkinID="GreenSmallTextbox"
                                    Width="80">
                                </asp:TextBox>
                                <asp:RequiredFieldValidator ID="RFV_txtSkipRequestKey" 
                                    runat="server" 
                                    ControlToValidate="txtSkipRequestKey"
                                    Display="Dynamic" 
                                    ErrorMessage="<br>Please enter skip request key" 
                                    SkinID="RequiredFieldValidation">
                               </asp:RequiredFieldValidator>
                               <asp:RegularExpressionValidator 
                                 ID="regVal_Quote" 
                                 ControlToValidate="txtSkipRequestKey" 
                                 CssClass="RequiredField"
                                 Text="<br>Please enter valid skip request key" 
                                 ValidationExpression="^[\d]{4,4}$" 
                                 runat="server"
                                 Display="Dynamic"
                                 SkinID="RequiredFieldValidation" 
                                  />
                              <%-- <asp:RangeValidator
                                  ID="RV_txtSkipRequestKey"
                                  ControlToValidate="txtSkipRequestKey"
                                  Display="Dynamic" 
                                  MaximumValue="9999" 
                                  MinimumValue="0"
                                  Text="<br>Please enter valid skip request key"
                                  Type="Integer"
                                  Runat="Server" 
                                  SkinID="RequiredFieldValidation">
                                  </asp:RangeValidator>
--%>
                            </td>
                            <td ></td>
                            <td  class="tablefont"></td>
                            <td ></td>
                            <td >
                                
                            </td>
                            <td ></td>
                            <td  class="tablefont"></td>
                            <td ></td>
                            <td >
                            </td>
                            <td ></td>
                      </tr>
                      <tr > 
                            <td height="1"  colspan="13"><img  src="../../images/spacer.gif" width="1" height="1" alt="" /></td>
                      </tr>
                      
                      <tr style="border-color:#F5F5F5; background-color:#DEF7D6;">
                            <td  style="height:25px;"></td>
                            <td colspan="2" align="right"  class="tablefont">Answer Key:</td>
                            <td align="center">
                                <asp:Label  ID="lblAnswerKey" Height="20" runat="server"  CssClass="TextBoxBlueBorderPin" Width="80"></asp:Label>
                            </td>
                            <td ></td>
                            <td  class="tablefont"></td>
                            <td ></td>
                            <td >
                                
                            </td>
                            <td ></td>
                            <td  class="tablefont"></td>
                            <td ></td>
                            <td >
                            </td>
                            <td ></td>
                      </tr>
                      <tr > 
                            <td height="1"  colspan="13"><img  src="../../images/spacer.gif" width="1" height="1" alt="" /></td>
                      </tr>
                      
                      <tr style="border-color:#F5F5F5; background-color:#DEF7D6;">
                            <td  style="height:100%;"></td>
                            <td  class="tablefont"></td>
                            <td ></td>
                            <td >
                            </td>
                            <td ></td>
                            <td  class="tablefont"></td>
                            <td ></td>
                            <td >&nbsp;
                                
                            </td>
                            <td ></td>
                            <td  class="tablefont"></td>
                            <td ></td>
                            <td >
                            </td>
                            <td ></td>
                      </tr>                                 
                    </table>                                                                          
              </td>
            </tr>
            <tr style="background-color:#BDE7BD;">
               <td style="border-top:1 solid #609BD3;height:31px;" >
                  <table style="width:100%; height:100%" border="0" cellpadding="0" cellspacing="0" >
                    <tr style="height:31;" >                        
                         <td style="width:100%;" align="center">                             
                            <asp:Button ID="btnSave" runat="server"  CssClass="Btn3D" CausesValidation="True" Text=" Generate Key " Width="90px" />
                            <button id="btnClose" name="btnClose" class="Btn3D"  style="width:80px;" onClick="parent.SkipReset();" runat="server" visible="false">Close</button>
                         &nbsp;</td>
                     </tr>
                   </table>
               </td>
            </tr>
        </table>
    </div>
       
 </form>
 <script language="javascript" type="text/javascript">
   
 </script>   
</body>

</html>
