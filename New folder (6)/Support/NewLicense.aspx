<%@ Page Language="VB" AutoEventWireup="false" CodeFile="~/Support/NewLicense.aspx.vb" Inherits="Support_NewLicense" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="RadComboBox.Net2" Namespace="Telerik.WebControls" TagPrefix="radC" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>New License</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <link href="../App_Themes/Default/Calendar/style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../scripts/functions.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>    
    <style type="Text/css">
        .pT5
        {
            padding-top:5px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <asp:UpdatePanel ID="updatepanel6" runat="server" UpdateMode="Always" RenderMode="inline">
       <ContentTemplate>
        <asp:HiddenField ID="hdnSupportStartDate" runat="server"  />
        <asp:HiddenField ID="hdnSupportEndDate" runat="server"  />
        <asp:HiddenField ID="hdnFranchiseID" runat="server"  />
        <asp:HiddenField ID="hdnProductID" runat="server"  />
        <asp:HiddenField ID="hdnMode" runat="server"  />
        <asp:HiddenField ID="hdnNSProductFranchiseID" runat="server"  />
        <asp:HiddenField ID="hdnOnSupport" runat="server"  />
       </ContentTemplate>
       </asp:UpdatePanel>   
       
        <table border="0" cellpadding="0" align="center" cellspacing="0" style="width: 100%; height:100%; border:0px;" class="tblAddFolder pad5px">         
            <tr>
                <td valign="top" style="width:60px;">
                  <span class="pT5">Store :</span><span class="RequiredField"> *</span></td>
                <td valign="top">   
                        <table cellpadding="0" cellspacing="0" border="0" style="padding:0px; margin:0px; background-color:#ffffff;">
                         <tr>
                            <td style="width:20px;border-top:solid 1px #82ABC7;border-bottom:solid 1px #82ABC7;border-left:solid 1px #82ABC7; padding:0px; margin:0px;" align="center"><img src="../images/icn_search.jpg" /></td>
                            <td style="border-top:solid 1px #82ABC7;border-bottom:solid 1px #82ABC7;border-right:solid 1px #82ABC7; padding:0px; margin:0px;">
                                <radC:RadComboBox id="ddlStores"
                                        runat="server"
                                        EnableViewState="true"  
                                        AllowCustomText="true"
                                        MarkFirstMatch="true"   
                                        Height="100"
                                        Skin="rnd" 
                                        AutoPostBack="true"  
                                        ShowToggleImage="false"  
                                        ShowWhileLoading="true"
                                        OffsetX="-15" 
                                        DataValueField="StoreIDClientID" 
                                        EnableLoadOnDemand="true"
                                        HighlightTemplatedItems="true"
                                        ItemRequestTimeout="500"
                                        Width="159px">
                                    <HeaderTemplate>
                                        <table style="width: 174px; text-align: left; font-size:10px;">
                                            <tr>
                                                <td style="width: 135px;">
                                                    Store
                                                </td>
                                                <td style="width: 30px;">
                                                    Client
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <table style="width: 173px; text-align: left;font-size:10px;">
                                            <tr>
                                                <td style="width: 135px;">
                                                    <%#DataBinder.Eval(Container.DataItem, "StoreNick")%>
                                                </td>
                                                <td style="width: 30px;">
                                                    <%#DataBinder.Eval(Container.DataItem, "ClientCode")%>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                            </radC:RadComboBox >
                            </td> 
                         </table> 
                        
                        <asp:CustomValidator ID="rfvStores"  Display="Dynamic" CssClass="RequiredField" ClientValidationFunction="checkvalue"  ErrorMessage="Required Store" runat="server"></asp:CustomValidator>
                       
                </td>
            </tr>
            <tr>
                <td valign="top" >
                   <span class="pT5">Product :</span><span class="RequiredField"> *</span></td>
                <td valign="top">
                <asp:UpdatePanel ID="updatepanel4" runat="server" RenderMode="Inline" UpdateMode="Conditional"  >
                    <ContentTemplate>
                   <asp:DropDownList ID="ddlProducts" style="font-size:11px;" runat="server" Width="180px" AutoPostBack="true"  
                        DataSourceID="" DataTextField="TitleAbbreviation" DataValueField="ID" Height="24"  onchange="ddlProducts_OnChange();" >
                        
                   </asp:DropDownList>
                    </ContentTemplate>
                      <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddlstores" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                   <asp:CompareValidator ID="CompareValidator2"  Display="Dynamic" CssClass="RequiredField"  ErrorMessage="Required Product" runat="server" ValueToCompare="0" Operator="GreaterThan" ControlToValidate="ddlProducts" />    
                   <asp:SqlDataSource ID="SDS_ProductsSupport" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                        SelectCommand="NS_Products_GetAllForList" SelectCommandType="StoredProcedure" DataSourceMode="DataReader">
                       <SelectParameters>
                         <asp:Parameter Name="ClientID" Type="Int32" />
                       </SelectParameters> 
                   </asp:SqlDataSource>
                   <asp:CustomValidator
                        ID="CV_CheckDuplicateProduct"
                        ErrorMessage="Product Name Already Exists."
                        CssClass="RequiredField"
                        Display="Dynamic"
                        runat="server" />
                   <asp:CustomValidator
                        ID="CV_CheckParentProduct"
                        ErrorMessage="First Subscribe For Parent Product."
                        CssClass="RequiredField"
                        Display="Dynamic"
                        runat="server" />                                 
                </td>
            </tr>
            <tr id="trNoOfLicenses" style="display:none;">
                <td valign="top" class="pT5"><span class="pT5"># of Licenses:</span><span class="RequiredField"> *</span></td>
                <td valign="top">
                    <asp:TextBox ID="txtNofLicenses" runat="server" 
                           MaxLength="2" Width="180px">
                    </asp:TextBox>   
                    <cc1:FilteredTextBoxExtender ID="ftxtNofLicenses" runat="Server" TargetControlID="txtNofLicenses" FilterType="Numbers"></cc1:FilteredTextBoxExtender>                 
                     <asp:RequiredFieldValidator ID="rfvNoOfLicenses" runat="server" 
                            ControlToValidate="txtNofLicenses" 
                            Display="Dynamic"  
                            ErrorMessage="<br>No of licenses is required" 
                            CssClass="RequiredField">
                    </asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="rvNoOfLicenses" runat="server" ControlToValidate="txtNofLicenses" Type="integer" ErrorMessage="<br>No of licenses must be greate then 0." MaximumValue="100" MinimumValue="1" Display="Dynamic" CssClass="RequiredField" ></asp:RangeValidator>                    
                </td>
            </tr>
            <tr>
                <td valign="top" style="white-space:nowrap;"><span class="pT5">Monthly Price:</span><span class="RequiredField"> *</span></td>
                <td valign="top">
                     <asp:UpdatePanel ID="updatepanel3" runat="server" RenderMode="Inline" UpdateMode="Conditional"  >
                        <ContentTemplate>
                        <asp:TextBox ID="txtMonthlyPrice" runat="server" Width="180px" style="font-size:11px;text-align:right;" MaxLength="10"></asp:TextBox>
                      </ContentTemplate>
                      <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddlProducts" EventName="SelectedIndexChanged" />
                            <asp:AsyncPostBackTrigger ControlID="ddlstores" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>   
                    <asp:RangeValidator ID="RV_txtMonthlyPrice" runat="server" ControlToValidate="txtMonthlyPrice" Type="Currency" ErrorMessage="Price Must Be Number Greater than 0." MaximumValue="1000000" MinimumValue="0" Display="Dynamic" CssClass="RequiredField" ></asp:RangeValidator>
                    <asp:RequiredFieldValidator ID="RFV_txtMonthlyPrice" runat="server" ControlToValidate="txtMonthlyPrice" Display="Dynamic"  ErrorMessage="Monthly Price is Required" CssClass="RequiredField"  ></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td valign="top"><span class="pT5">Start Date:</span><span class="RequiredField"> *</span></td>
                <td valign="top">
                <asp:UpdatePanel ID="updatepanel1" runat="server" RenderMode="Inline"   >
                  <ContentTemplate>
                    <asp:TextBox ID="txtStartDate" runat="server" 
                       MaxLength="10" style="font-size:11px;"
                       ReadOnly="true" 
                       onfocus="imgDDCalander.click();"
                       Width="153px">
                    </asp:TextBox>
                    <img id="imgDDCalander" align="absMiddle"  border="0" onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtStartDate.ClientID %>', 'M/d/yyyy');"
                        onmouseover="style.cursor='hand';" src="../images/ico_calendar.jpg" />
                    <asp:RequiredFieldValidator ID="RFV_txtStartDate" 
                            runat="server" 
                            ControlToValidate="txtStartDate" 
                            Display="Dynamic"  
                            ErrorMessage="Support Start Date Required" 
                            CssClass="RequiredField">
                    </asp:RequiredFieldValidator>
                     <asp:CustomValidator
                            ID="CVS_StartDate"
                            ErrorMessage=""
                            CssClass="RequiredField"
                            Display="Dynamic"
                            runat="server" />   
                   </ContentTemplate> 
                   </asp:UpdatePanel> 
                    
                </td>
            </tr>            
            <tr>
                <td valign="top"><span class="pT5">End Date:</span><span class="RequiredField"> *</span></td>
                <td valign="top">
                 <asp:UpdatePanel ID="updatepanel2" runat="server" RenderMode="Inline"   >
                  <ContentTemplate>
                    <asp:TextBox ID="txtEndDate" runat="server" 
                           MaxLength="10" style="font-size:11px;"
                           ReadOnly="true" 
                           onfocus="imgMMCalander.click();"
                           Width="153px">
                       </asp:TextBox>
                       <img id="imgMMCalander" align="absMiddle"  border="0" onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtEndDate.ClientID %>', 'M/d/yyyy');"
                           onmouseover="style.cursor='hand';" src="../images/ico_calendar.jpg" />
                    <asp:RequiredFieldValidator ID="RFV_txtEndDate" runat="server" 
                            ControlToValidate="txtEndDate" 
                            Display="Dynamic"  
                            ErrorMessage="Support End Date Required" 
                            CssClass="RequiredField">
                    </asp:RequiredFieldValidator>
                    <asp:CustomValidator
                            ID="CVS_EndDate"
                            ErrorMessage=""
                            CssClass="RequiredField"
                            Display="Dynamic"
                            runat="server" />
                   </ContentTemplate> 
                   </asp:UpdatePanel> 
                   
                </td>
            </tr>
            <tr>
                <td valign="top"><span id="lblnotes" runat="server"> Notes:</span></td>
                <td valign="top" style="height:90%;">
                 <asp:UpdatePanel ID="updatepanel5" runat="server" RenderMode="Inline"   >
                  <ContentTemplate>
                    <asp:TextBox ID="txtNotes" runat="server" Width="180px" Rows="4" TextMode="MultiLine" style="font-size:11px;"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="revNotes" runat="server" ValidationExpression="^[\s\S]{0,490}$" 
                        ControlToValidate="txtNotes"  CssClass="RequiredField" Display="Dynamic"  ErrorMessage="Max 500 char Allowed"></asp:RegularExpressionValidator>
                   </ContentTemplate>
                   </asp:UpdatePanel>                       
                </td>
            </tr>                        
            <tr>
                <td align="center" colspan="2" style="height:30px;">                    
                    <asp:Button ID="btnSave" runat="server" Text="Save"  CssClass="btnSilver" />&nbsp;
                    <input id="btnCancel" type="button" value="Cancel" class="btnSilver" onClick="parent.CloseNewLicenseDiv();" />
                </td>                
            </tr>
        </table>                          
    <script type="text/javascript" language="javascript">
        var ddlstores = <%= ddlstores.ClientID %>; 
        function checkvalue(sender,args){
        if(ddlstores.GetValue() == '0' || ddlstores.GetValue() == '')                                
           args.IsValid = false;
        else args.IsValid = true;            
        }
        function disabledate()
        {
           document.getElementById('imgDDCalander').disabled = 'true';   
        }
        function enabledate()
        {
           document.getElementById('imgDDCalander').disabled = 'false';   
        }
         function disableenddate()
        {
           document.getElementById('imgMMCalander').disabled = 'true';   
        }
            
        function ddlProducts_OnChange(){    
            var productId = document.getElementById('<%= ddlProducts.ClientID %>').value;
            if(parseInt(productId) == parseInt('<%= Portal.BLL.Enumeration.NSProductIDs.ESETAntiVirus %>'))
            {                    
                document.getElementById('trNoOfLicenses').style.display = 'inline';
                ValidatorEnable(document.getElementById('<%= RFV_txtMonthlyPrice.ClientID %>'), false);
            }
            else{
                document.getElementById('trNoOfLicenses').style.display = 'none';   
                ValidatorEnable(document.getElementById('<%= rfvNoOfLicenses.ClientID %>'), false);
                ValidatorEnable(document.getElementById('<%= rvNoOfLicenses.ClientID %>'), false);
            }
        }
    </script>
    </form>
</body>
</html>
