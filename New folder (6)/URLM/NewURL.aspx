<%@ Page Language="VB" AutoEventWireup="false" EnableTheming="true" EnableViewState="true" Theme="Default" CodeFile="NewURL.aspx.vb" Inherits="URLM_NewURL" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>URL Management</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js">     </script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js">      </script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js">   </script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js">   </script>
    <meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.Fade(duration=.2)" />  
</head>
<body  style ="margin:0px; background-color:#DAF5D6; height:100%; width:100%;">
    <form id="form1" runat="server">
    <div>
        <table cellspacing="0" border="0" style="height:100%; width:100%;" class="FormTable"  >
              <tr>
                  <td  style="height:31px;font-size:13px;font-weight:bold;padding:5px;border-bottom:1px solid #609BD3;"> 
                      <asp:Label runat="server" ID="lblTitle" Text="New URL" ></asp:Label>&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorMessage" CssClass="ErrorMessage" Text=" " Visible="false" ></asp:Label>
                      <asp:HiddenField ID="hdnURLID" runat="server" Value="0" />
                  </td>
              </tr>              
              <tr>
                 <td align="center" style="vertical-align:top; height:100%; background-color:#DAF5D6; width:100%;" >                        
                   <div  style="overflow:auto;background-color:#DAF5D6; " id="divNewURL" runat="server" >
                        <table  style="height:100%;" cellspacing="0" cellpadding="0" width="100%" border="0">                                    
                          <tr>
                            <td style="width:15%;background-color:#DAF5D6;" ></td>
                              <td style="PADDING-BOTTOM: 10px; PADDING-TOP:10px; background-color:#DAF5D6;" align="center" >
                                <table cellspacing="4" cellpadding="1" width="100%" class="FormInnerTable" align="center" border="0">
                                      <tr style="background-color:#DAF5D6;">                                                             
                                            <td valign="top" width="10%" ></td>   
                                            <td valign="top" width="15%" class="SimpleLabel">URL:<span class="ErrorMessage">*</span> </td>
                                            <td style="WIDTH: 85%;" valign="top">
                                                <asp:TextBox SkinID="GreenSmallTextbox"  MaxLength="150" id="txtURL" runat="server" Width="200"></asp:TextBox> 
                                                <asp:RequiredFieldValidator id="RequiredFieldValidator2" 
                                                        CssClass="ErrorMessage"
                                                        runat="server"
                                                        ControlToValidate="txtURL"
                                                        ValidationGroup="NewURL"
                                                        ErrorMessage="Enter URL."
                                                        Display="Dynamic">
                                                 </asp:RequiredFieldValidator>
                                                   <asp:RegularExpressionValidator ID="regUrl" 
                                                   runat="server" 
                                                   CssClass="ErrorMessage"
                                                ControlToValidate="txtURL" 
                                                Display="Dynamic" 
                                                ValidationExpression="^[^<>'&quot;]*$"
                                                ErrorMessage="Please enter valid URL ( &quot; &lt; &gt; ' not allowed ).<br/>" 
                                                ValidationGroup="NewURL">
                                                </asp:RegularExpressionValidator>

                                                <%-- <asp:RegularExpressionValidator ID="regUrl" 
                                                 runat="server" 
                                                 ValidationGroup="NewURL" 
                                                 CssClass="ErrorMessage" 
                                                 Font-Bold="false" 
                                                 ControlToValidate="txtURL" 
                                                 Display="Dynamic" 
                                                 ErrorMessage="Enter valid URL." 
                                                 ValidationExpression="([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)?">
                                                 </asp:RegularExpressionValidator>--%>
                                            </td>
                                       </tr>
                                      <tr style="background-color:#DAF5D6;">   
                                            <td valign="top" width="10%" ></td>                                                                
                                            <td valign="top" class="SimpleLabel">Registrar:<span class="ErrorMessage">*</span></td>
                                            <td  valign="top">
                                                <asp:DropDownList SkinID="SmallTextCombo"   id="ddlRegistrar1" runat="server" DataValueField="ID" DataTextField="DataText" DataSourceID="srcRegistrar" Width="200"></asp:DropDownList> 
                                                   <asp:ObjectdataSource
                                                         id="srcRegistrar"
                                                         runat="server"
                                                         Typename="URLM"
                                                         SelectMethod="GetAllRegistrars">         
                                                  </asp:ObjectdataSource>
                                                <asp:CompareValidator id="CompareValidator4" runat="server"  CssClass="ErrorMessage" ControlToValidate="ddlRegistrar1" ValidationGroup="NewURL" ErrorMessage="Select Registrar" Display="Dynamic" ValueToCompare="0" Operator="NotEqual"></asp:CompareValidator>
                                            </td>
                                       </tr>
                                      <tr style="background-color:#DAF5D6;">
                                             <td valign="top" width="10%" ></td>                                                                 
                                             <td valign="top" class="SimpleLabel">Category:<span class="ErrorMessage">*</span></td>
                                             <td  valign="top">
                                                <asp:DropDownList SkinID="SmallTextCombo"  
                                                     id="ddlCategory1" 
                                                     runat="server" 
                                                     DataValueField="ID" 
                                                     DataTextField="DataText" 
                                                     DataSourceID="srcCategory" 
                                                     Width="200">
                                                </asp:DropDownList>
                                                <asp:CompareValidator id="CompareValidator3" 
                                                     runat="server" 
                                                     ControlToValidate="ddlCategory1" 
                                                     ValidationGroup="NewURL" 
                                                     CssClass="ErrorMessage"
                                                     ErrorMessage="Select Category" 
                                                     Display="Dynamic" 
                                                     ValueToCompare="0" 
                                                     Operator="NotEqual">
                                                </asp:CompareValidator>
                                                 <asp:ObjectdataSource
                                                     id="srcCategory"
                                                     runat="server"
                                                     Typename="URLM"
                                                     SelectMethod="GetAllCategories">         
                                                 </asp:ObjectdataSource>
                                           </td>
                                       </tr>
                                      <tr style="background-color:#DAF5D6;">
                                            <td valign="top" width="10%" ></td>                                                                  
                                            <td valign="top" class="SimpleLabel">Account:<span class="ErrorMessage">*</span> </td>
                                            <td valign="top">
                                               <asp:DropDownList SkinID="SmallTextCombo"
                                                     id="ddlAccount1" 
                                                     runat="server" 
                                                     DataValueField="ID" 
                                                     DataTextField="DataText" 
                                                     DataSourceID="srcAccounts" 
                                                     EnableViewState="true" 
                                                     Width="200">
                                               </asp:DropDownList> 
                                               <asp:ObjectdataSource
                                                     id="srcAccounts"
                                                     runat="server"
                                                     TypeName="URLM"
                                                     SelectMethod="GetAllAccounts" >         
                                               </asp:ObjectdataSource>  
                                               <asp:CompareValidator id="CompareValidator2" 
                                                      runat="server" 
                                                      ControlToValidate="ddlAccount1" 
                                                      CssClass="ErrorMessage"
                                                      ValidationGroup="NewURL" 
                                                      ErrorMessage="Select Account" 
                                                      Display="Dynamic" 
                                                      ValueToCompare="0" 
                                                      Operator="NotEqual">
                                              </asp:CompareValidator>
                                            </td>
                                      </tr>
                                      <tr style="background-color:#DAF5D6;">
                                            <td valign="top" width="10%" ></td>                                                                  
                                            <td valign="top" class="SimpleLabel">Country: </td>
                                            <td valign="top">
                                               <asp:DropDownList SkinID="SmallTextCombo"
                                                     id="ddlCountry" 
                                                     runat="server" 
                                                     DataValueField="ID" 
                                                     DataTextField="Name" 
                                                     DataSourceID="odsGetAllCountries" 
                                                     EnableViewState="true" 
                                                     Width="200">
                                               </asp:DropDownList> 
                                                                                              <asp:ObjectdataSource
                                                     id="odsGetAllCountries"
                                                     runat="server"
                                                     TypeName="URLM"
                                                     SelectMethod="GetAllCountries" >         
                                               </asp:ObjectdataSource>  
                                            </td>
                                      </tr>
                                      <tr style="background-color:#DAF5D6;">
                                            <td valign="top" width="10%" ></td>                                                                  
                                            <td valign="top" class="SimpleLabel">Exp. Date:<span class="ErrorMessage">*</span> </td>
                                            <td valign="top">
                                                <asp:TextBox SkinID="GreenSmallTextbox"  id="txtExpirydate" runat="server" Width="170"></asp:TextBox> <img style="CURSOR:pointer" onclick="setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtExpirydate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');" height="20" src="../images/ico_calendar.jpg" width="24" align=absMiddle alt="" />&nbsp; 
                                                <asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" ControlToValidate="txtExpirydate" CssClass="ErrorMessage" ValidationGroup="NewURL" ErrorMessage="Enter Date" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator> 
                                                <asp:CompareValidator ID="CompareValidator1"  CssClass="ErrorMessage" runat="server" ControlToValidate="txtExpirydate"   Display="Dynamic" ErrorMessage="Enter valid Date" Operator="DataTypeCheck"  Type="Date" ValidationGroup="NewURL"></asp:CompareValidator>
                                            </td>
                                      </tr>
                                      <tr style="background-color:#DAF5D6;">
                                            <td valign="top" width="10%" ></td>                                                                  
                                            <td valign="top" class="SimpleLabel">Act. Date: </td>
                                            <td valign="top">
                                                <asp:TextBox SkinID="GreenSmallTextbox" onfocus="this.blur();" id="txtActivationDate" runat="server" Width="170"></asp:TextBox> <img style="CURSOR:pointer" onclick="setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtActivationDate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');" height="20" src="../images/ico_calendar.jpg" width="24" align=absMiddle alt="" />&nbsp; 
                                            </td>
                                      </tr>
                                      <tr style="background-color:#DAF5D6;">
                                            <td valign="top" width="10%" ></td>                                                                  
                                            <td valign="top" class="SimpleLabel">Reg. Date: </td>
                                            <td valign="top">
                                                <asp:TextBox SkinID="GreenSmallTextbox"  onfocus="this.blur();" id="txtRegistration" runat="server" Width="170"></asp:TextBox> <img style="CURSOR:pointer" onclick="setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtRegistration.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');" height="20" src="../images/ico_calendar.jpg" width="24" align=absMiddle alt="" />&nbsp; 
                                                
                                            </td>
                                      </tr>
                                      <tr style="background-color:#DAF5D6;">
                                            <td valign="top" width="10%" ></td>                                                               
                                            <td valign="top" class="SimpleLabel">
                                                WhoisServer: 
                                            </td>
                                            <td valign="top">
                                                <asp:TextBox SkinID="GreenSmallTextbox"  id="txtWhoisServer" runat="server" Width="200" ></asp:TextBox>
                                            </td>
                                      </tr>
                                      <tr style="background-color:#DAF5D6;">  
                                            <td valign="top" width="10%" ></td>                                                                
                                            <td valign="top" class="SimpleLabel">NameServer1: </td>
                                            <td  valign="top">
                                                <asp:TextBox SkinID="GreenSmallTextbox"  MaxLength="70" id="txtnameServer1" runat="server" Width="200"></asp:TextBox> 
                                            </td>
                                      </tr>
                                      <tr style="background-color:#DAF5D6;">
                                           <td valign="top" width="10%" ></td>   
                                           <td valign="top" class="SimpleLabel">NameServer2: </td>
                                           <td class="SimpleLabel" valign="top">
                                                <asp:TextBox SkinID="GreenSmallTextbox"  id="txtNameServer2" runat="server" Width="200" MaxLength="70"></asp:TextBox> 
                                           </td>
                                       </tr>
                                      <tr style="background-color:#DAF5D6;">
                                        <td valign="top" width="10%" ></td>                                                               
                                        <td valign="top" class="SimpleLabel">Pointing to: </td>
                                        <td  valign="top">
                                            <asp:TextBox SkinID="GreenSmallTextbox"  id="txtreferralURL" runat="server" MaxLength="70" Width="200"></asp:TextBox> 
                                        </td>
                                     </tr>
                                     <tr style="background-color:#DAF5D6;">
                                        <td valign="top" width="10%" ></td>  
                                        <td  align="left" class="SmallText" colspan="2" valign="bottom">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Fields marked with an asterisk <span class="RequiredField" style="color: #000000"><span
                                   style="color: #ff0000">*</span></span> are required.</td>
                                     </tr>                                            
                                </table>                                       
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
                      ValidationGroup="NewURL"
                      CssClass="Btn3D" 
                      Width="80px"  />&nbsp;&nbsp;
                   <asp:Button  
                      ID="btnBack"
                      PostBackUrl="~/URlm/UrlmHome.aspx"  
                      runat="server"
                      Text="Cancel"  CausesValidation="false" 
                      CssClass="Btn3D" />      
                 </td>
              </tr>                              
        </table>
    </div>    
    </form>
</body>   
</html>