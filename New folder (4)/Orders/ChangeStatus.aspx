<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ChangeStatus.aspx.vb" Inherits="Orders_ChangeStatus" Theme="Default" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Order Status</title>
    <link href="../../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" /> 
    <script src="../scripts/calendar.js"></script>
    <script src="../scripts/calendar-fs.js"></script>
    <script src="../scripts/calendar-en.js"></script>    
    <script src="../scripts/functions.js"></script>    
    
    <style type="text/css">
        .RequriedField{
            color:Red;            
        }
        .NotesHeader
        {
            font-weight:bold;
            border-bottom:1px solid #000;
        }    
    </style>    
</head>
<body style="padding:0; border:0; margin:0; width:100%; height:100%; background-color:#DAF5D6; font-size:12px; font-family:Arial, Verdana, Sans-Serif, Helvetica;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="smOrderStatus" runat="server">
    </asp:ScriptManager>
    <div id="divDisable" class="modalBackground" style="z-index:0;" ></div>
    <div >            
        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height:99%;" >            
        <tr>
            <td colspan="2" align="center" style="padding-left:10px;">
               <table border="0" cellpadding="0" cellspacing="0" style="width:100%; height:100%; font-size:12px; font-family:Arial, Verdana, Sans-Serif, Helvetica; padding:3px 3px 3px 7px;">                   
                  <tr>
                        <td style="width:30%; padding-top:10px;" valign="top">
                         Set Status :
                        </td>
                        <td style="width:70%; padding-top:10px;">
                            <asp:DropDownList 
                                    ID="ddlOrderStatus" 
                                    DataSourceID="sds_OrdersStatus"
                                    runat="server" 
                                    SkinID="SmallTextCombo"
                                    onchange="ShowTR(this);"
                                    DataTextField="Status" 
                                    DataValueField="ID"                                     
                                    Width="170px">
                                  </asp:DropDownList>
                                  <asp:UpdatePanel ID="upValidatorOrderStatus" runat="server" UpdateMode="Always">                                    
                                    <ContentTemplate>    
                                        <asp:CustomValidator ID="cvOrderStatus" ValidationGroup="vgOrder" runat="server" Display="Dynamic" ControlToValidate="ddlOrderStatus" ErrorMessage="Order Status must be Processed for Shipment"></asp:CustomValidator>              
                                    </ContentTemplate>
                                 </asp:UpdatePanel>
                                  <asp:SqlDataSource 
                                        ID="sds_OrdersStatus" 
                                        runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                        SelectCommand="SCM_OrderStatus_GetAll" 
                                        SelectCommandType="StoredProcedure" 
                                        DataSourceMode="DataSet">                                                                        
                                  </asp:SqlDataSource>                                    
                        </td>                
                    </tr>     
                    <tr >
                        <td valign="top">Notes : <span class="RequriedField">*</span></td>
                        <td>
                            <asp:TextBox ID="txtNotes" runat="server" Rows="3" TextMode="MultiLine" Width="300px" CssClass="textarea" SkinID="GreenMultilineTextbox"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvNotes" runat="server" ControlToValidate="txtNotes"
                                    Display="Dynamic" ErrorMessage="<br>Enter Notes" ValidationGroup="vgOrder"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revNotes" runat="server" Display="Dynamic" ControlToValidate="txtNotes" ValidationGroup="vgOrder" ValidationExpression="^[\s\S]{1,400}$" ErrorMessage="<br>Max 4000 characters"></asp:RegularExpressionValidator>
                            <asp:RegularExpressionValidator ID="revNotesHtml" runat="server" Display="Dynamic" ControlToValidate="txtNotes" ValidationGroup="vgOrder" ValidationExpression="^[^<>]*$" ErrorMessage="<br>Enter Valid text"></asp:RegularExpressionValidator>
                         </td>
                    </tr>       
                 </table>
                </td>
            </tr>           
            <tr id="trShippingInfo" style="display:none;">
                <td colspan="2" style="width:100%;padding-left:10px;" align="center">
                    <table border="0" cellpadding="0" cellspacing="0" style="width: 100%;font-size:12px; font-family:Arial, Verdana, Sans-Serif, Helvetica; border:solid 1px #50AF43; padding:2px;">                                                                                  
                        <tr>
                            <td>Ship Via : <span class="RequriedField">*</span></td>
                            <td><asp:DropDownList ID="ddlShipVia" runat="server" Width="170px" DataSourceID="sdsShippingCompanies" DataTextField="Name" DataValueField="ID" SkinID="SmallTextCombo">                                   
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvShipVia" runat="server" ControlToValidate="ddlShipVia"
                                    Display="Dynamic" ErrorMessage="<br>Please Select Ship Via" InitialValue="0" ValidationGroup="vgShipping"></asp:RequiredFieldValidator>
                                <asp:SqlDataSource ID="sdsShippingCompanies" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                SelectCommand="SCM_OrdersShippingCompanies_GetAll" SelectCommandType="StoredProcedure">
                            </asp:SqlDataSource>
                            </td>
                            <td>Ship Date :<span class="RequriedField">*</span></td>
                            <td><asp:TextBox ID="txtShipDate" runat="server" Width="170px" ReadOnly="true" onclick="imgShipDate.click();" SkinID="GreenSmallTextbox" ></asp:TextBox>
                            <img id="imgShipDate" onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtShipDate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                                   onmouseover="style.cursor='hand';" style="display:none;" />
                                <asp:RequiredFieldValidator ID="rfvShipDate" runat="server" ControlToValidate="txtShipDate"
                                    Display="Dynamic" ErrorMessage="<br>Please Select Ship Date " ValidationGroup="vgShipping"></asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td>Ship. Charges :<span class="RequriedField">*</span></td>
                            <td><asp:TextBox ID="txtShipCharges" runat="server" Width="170px" MaxLength="10" SkinID="GreenSmallTextbox"></asp:TextBox>
                                <asp:RequiredFieldValidator
                                    ID="rfvShipCharges" runat="server" ControlToValidate="txtShipCharges"
                                    Display="Dynamic" ErrorMessage="<br>Enter Ship Charges"  ValidationGroup="vgShipping"></asp:RequiredFieldValidator>
                                <asp:CompareValidator 
                                    ID="cvShipingCharges" runat="server" ControlToValidate="txtShipCharges"
                                    Display="Dynamic" ErrorMessage="<br>Enter Valid Ship Charges" ValidationGroup="vgShipping" Operator="DataTypeCheck"
                                    Type="Double"></asp:CompareValidator></td>
                            <td>Tracking No :<span class="RequriedField">*</span></td>
                            <td><asp:TextBox ID="txtTrackingNo" runat="server" Width="170px" MaxLength="50" SkinID="GreenSmallTextbox"></asp:TextBox>
                                <asp:RequiredFieldValidator 
                                    ID="rfvTrackingNo" runat="server" ControlToValidate="txtTrackingNo"
                                    Display="Dynamic" ErrorMessage="<br>Enter Tracking no" ValidationGroup="vgShipping"></asp:RequiredFieldValidator>
                                <asp:CompareValidator 
                                    ID="cvTrackingNo" runat="server" ControlToValidate="txtTrackingNo"
                                    Display="Dynamic" ErrorMessage="<br>Enter Valid Tracking No" ValidationGroup="vgShipping" Operator="DataTypeCheck"
                                    Type="String"></asp:CompareValidator></td>
                        </tr>
                        <tr>
                            <td valign="top">Ship Notes :</td>
                            <td valign="top">
                                <asp:TextBox ID="txtShipNotes" runat="server" Rows="3" TextMode="MultiLine" Width="170px" SkinID="GreenMultilineTextbox"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="revShipNotes" runat="server" Display="Dynamic" ControlToValidate="txtShipNotes" ValidationGroup="vgShipping" ValidationExpression="^[\s\S]{1,4000}$" ErrorMessage="<br>Max 4000 characters"></asp:RegularExpressionValidator>
                            <asp:RegularExpressionValidator ID="revShipNotesHtml" runat="server" Display="Dynamic" ControlToValidate="txtShipNotes" ValidationGroup="vgShipping" ValidationExpression="^[^<>]*$" ErrorMessage="<br>Enter Valid text"></asp:RegularExpressionValidator>
                            </td>
                            <td valign="top">ETA :</td>
                            <td valign="top">
                                <asp:TextBox ID="txtETADate" runat="server" ReadOnly="true" Width="170px" onclick="imgETADate.click();" SkinID="GreenSmallTextbox" ></asp:TextBox>
                                <img id="imgETADate" onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtETADate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                                   onmouseover="style.cursor='hand';" style="display:none;" />
                            </td>                                
                        </tr>
                    </table>
                </td>                
            </tr>                          
            <tr>                
                <td colspan="2" align="center" style="padding-top:5px;">
                    <asp:Button ID="btnUpdateStatus" CssClass="LeadGreenButton" runat="server" Text="Save" Width="75px" Height="22px" OnClientClick="ValidatePage();"/>
                    <input id="btnCancel" type="button" class="LeadGreenButton" value="Cancel" style="height:22px; width:75px;" onclick="ClearFields();" />
                </td>
            </tr> 
            <tr>
                <td colspan="2" style="height:100%;" valign="top">
                    <table border="0" cellpadding="0" cellspacing="0" style="width:100%;height:100%;">
                        <tr>
                            <td colspan="2" style="font-weight:bold; font-size:14px; padding:5px 5px 5px 10px;">
                             Order Status History
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="padding-left:10px; height:100%;" valign="top">
                                <div style="width:100%; height:100%; overflow-y:auto; border:solid 1xp #86B1D3;" class="divScroll">
                                    <asp:UpdatePanel ID="upOrderHistory" runat="server" UpdateMode="Conditional">                                    
                                    <ContentTemplate>
                                    <asp:GridView ID="gvwOrderHistory" runat="server" AutoGenerateColumns="False" SkinID="GridViewNoPaging" DataSourceID="sdsOrderNotes">
                                        <Columns>
                                            <asp:BoundField HeaderText="Status"  DataField="OrderStatus"/>
                                            <asp:TemplateField HeaderText="Date">
                                                <ItemTemplate><%#Eval("EnteredDate")%></ItemTemplate>
                                            </asp:TemplateField>                                        
                                            <asp:BoundField HeaderText="Contact Name" DataField="ContactName" />
                                            <asp:TemplateField HeaderText="Notes">
                                                <ItemTemplate><%#Functions.StringTruncate(Eval("Notes"), 50)%></ItemTemplate>
                                            </asp:TemplateField>                                        
                                        </Columns>
                                    </asp:GridView>
                                    </ContentTemplate>                                    
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="btnUpdateStatus" EventName="Click" />
                                    </Triggers>
                                    </asp:UpdatePanel>
                                    <asp:SqlDataSource ID="sdsOrderNotes" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                        SelectCommand="SCM_Orders_NotesGetByOrderID" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:QueryStringParameter Name="OrderID" QueryStringField="OrderID" Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>                       
        </table>              
        <div id="divMail" style="position:absolute; width:99%; height:95%; top:5; left:1%; display:none; z-index:1000; padding:0; margin:0; border:solid 1px #000;">
        <table border="0" cellpadding="0" cellspacing="0" style="width:100%; height:100%; background-color:#DAF5D6; padding:5px; font-size:12px; font-family:Arial, Verdana, Sans-Serif, Helvetica;">
            <tr style="background-color:Black; ">
                <td colspan="2" style="font-weight:bold; font-size:14px; font-family:Arial, Verdana, Sans-Serif, Helvetica; color:#fff; padding-left:3px;">Email Confirmation</td>                
            </tr>
            <tr>
                <td style="width:20%;">From :</td>
                <td style="width:70%;"><asp:Literal ID="ltrlMailFrom" runat="server"></asp:Literal></td>
            </tr>
            <tr>
                <td>To :</td>
                <td><asp:Literal ID="ltrlMailTo" runat="server"></asp:Literal></td>
            </tr>
            <tr>
                <td>Subject :</td>
                <td><asp:Literal ID="ltrlSubject" runat="server"></asp:Literal></td>
            </tr>
            <tr>
                <td colspan="2" style="height:60%; padding:10px;" valign="top">
                <asp:Literal ID="ltrlMailBody" runat="server"></asp:Literal>
                </td>                
            </tr>
             <tr>
                <td colspan="2">
                <asp:Literal ID="ltrlSenderName" runat="server"></asp:Literal>
                <br />
                <asp:Literal ID="ltrlJobTitle" runat="server"></asp:Literal>                                
                <span class="SimpleSmall">
                <asp:Literal ID="ltrlNetsolaceAddress" runat="server"></asp:Literal>     
                </span>
                </td>                
            </tr>           
             <tr>
                <td colspan="2" align="center" style="padding:10px">
                    <asp:Button ID="btnSendMail" runat="server" CssClass="LeadGreenButton" Width="75px" Height="22px" Text="Send Mail" />
                    <input id="btnDontSend" type="button" class="LeadGreenButton" style="width:75px; height:22px;" value="Don't Send" onclick="ClearFields(); parent.ReloadPage();" />
                </td>                
            </tr>
        </table>
    </div>
    </div>    
    </form>
</body>
</html>
<script language="javascript" type="text/javascript">
        function ShowTR(combo)
        {                                    
            if(combo.value == 5)        //Incase the selected value is shipment 
            {
               document.getElementById('trShippingInfo').style.display = 'inline';
            }               
            else
            {
                document.getElementById('trShippingInfo').style.display = 'none';
            }
        }
        
        function ValidatePage()
        {            
            if(Page_ClientValidate("vgOrder"))
            {
                if(document.getElementById('<%= ddlOrderStatus.ClientID %>').value == 5)
                {               
                    return Page_ClientValidate("vgShipping");
                }
            }                                                                                     
        }
        
        function ClearFields()
        {         
            
            document.getElementById('<%= txtNotes.ClientID %>').value = '';            
            document.getElementById('<%= ddlShipVia.ClientID %>').value = '0';            
            document.getElementById('<%= txtShipDate.ClientID %>').value = '';            
            document.getElementById('<%= txtShipCharges.ClientID %>').value = '';            
            document.getElementById('<%= txtTrackingNo.ClientID %>').value = '';
            document.getElementById('<%= txtShipNotes.ClientID %>').value = '';
            document.getElementById('<%= txtETADate.ClientID %>').value = '';
            document.getElementById('trShippingInfo').style.display = 'none';             
            parent.CloseDiv();           
        }
        
        function ShowMailDiv()
        {
            setWindowedControlsVisibility(window, 'hidden');
            document.getElementById('<%= btnUpdateStatus.ClientID %>').style.visibility = 'hidden';
            document.getElementById('btnCancel').style.visibility = 'hidden';
            document.getElementById('<%= txtShipNotes.ClientID %>').style.visibility = 'hidden';
            divDisable.style.width="100%";
            divDisable.style.height="100%";
            divMail.style.display='inline';   
        }
        
 </script>
