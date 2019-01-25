<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Client_Services.aspx.vb" Inherits="Admin_ClientServices_Add" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Client Services</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
</head>
<body style ="margin :0px; height:100%; width:100%;" >
    <form id="form1" runat="server">
        <asp:HiddenField ID="hdnClientID" runat="server" />
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <table  cellspacing="0" border="0" style="height:100%; width:100%; padding-left: 1em; "  >
                  <tr>
                    <td  align="center" style="vertical-align:top; height:100%; width:100%; background-color:white; " >                        
                      <div  style="overflow:auto; height:100%; width:100%; padding:10px;" id="Div1" class="ScrollBarHomeTicket">  
                       <asp:Repeater ID="rptProductTypes" runat="server" DataSourceID="odsProductsModules">
                          <HeaderTemplate>
                            <table style="" cellpadding="0" cellspacing="0" border="0">
                                      <tr style="padding:5px;">
                                        <td style="border-bottom:solid 1px #82BDE9;">&nbsp;</td>
                                        <td style="border-bottom:solid 1px #82BDE9; font-size:smaller; font-weight:bold;">Price</td>
                                        <td style="border-bottom:solid 1px #82BDE9; font-size:smaller; font-weight:bold;">Bill To</td>
                                    </tr>
                          </HeaderTemplate> 
                          <ItemTemplate>
                            <tr style="padding:5px;">
                                        <td style="border-bottom:solid 2px #82BDE9; width:350px;"><span style="font-family:Comic Sans MS; font-weight:bold; font-size:13px; ">Subscribed for:</span>&nbsp;<span style="font-size:12px; font-weight:lighter; font-family:@Arial Unicode MS;"><%#Eval("ProductType")%></span></td>
                                        <td style="border-bottom:solid 2px #82BDE9; font-size:smaller; font-weight:bold;width:150px;">&nbsp;</td>
                                        <td style="border-bottom:solid 2px #82BDE9; font-size:smaller; font-weight:bold; width:150px;">&nbsp;</td>
                                    </tr>
                            <td colspan="3" >
                          <asp:Repeater ID="rptProducts" runat="server" DataSource='<%# Container.DataItem.CreateChildView("ProductTypes") %>' >
                             <HeaderTemplate>
                                 <table style="border:solid 0px #82BDE9" cellpadding="0" cellspacing="0" border="0" class="FranSmallWhileSubTable" >
                            </HeaderTemplate> 
                             <ItemTemplate>
                                    <tr >
                                        <td style="border-top:solid 0px #C1E1BC; padding-left:5px; padding-top:2px; width:390px;">
                                            <asp:Label ID="lblProductID" runat="server" Visible="false" Text='<%#Eval("ID") %>' ></asp:Label>
                                            <img src='<%#IIf(Eval("Checked")=True,"../images/chkBox_chkd.jpg","../images/chkBox_unChkd.jpg") %>' />&nbsp;<span title='<%# Eval("Title")%>' style="font-size:11px; font-weight:bold;  ">
                                            <%#Functions.StringTruncate(Eval("Title"), 47)%></span>
                                        </td>   
                                        <td style="border-top:solid 0px #C1E1BC; padding-left:3px; padding-bottom:3px; padding-top:2px; width:170px;">
                                            <b><asp:Label ID="lblProductPrice" runat="server" Text='<%#String.Format("{0:C}",Eval("Price"))%>'></asp:Label></b>
                                            &nbsp;&nbsp;<span style="font-size:x-small; ">per license</span>
                                            </td>
                                        <td style="border-top:solid 0px #C1E1BC;  padding-left:6px; padding-bottom:3px;  padding-top:2px; width:170px;">
                                             <asp:Label ID="lblBillTo" runat="server" Text='<%#Functions.BillToOption(Eval("BillTo"))%>'></asp:Label>&nbsp;<span style=" font-weight:bold  ;display:<%#IIf(Eval("BillTo")=3,"inline","none") %>">(corporate will pay&nbsp;<%#Eval("CorporatePay")%>%)</span>
                                           </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="padding-left:20px; border-bottom:0px;">
                                            <asp:Repeater ID="rptModules" runat="server" DataSource='<%# Container.DataItem.CreateChildView("ProductModules") %>'>
                                                <HeaderTemplate>
                                                    <table style=""  cellpadding="0" cellspacing="0" border="0">
                                                </HeaderTemplate>
                                                <ItemTemplate >
                                                    <tr>
                                                        <td style="width:371px; padding-left:3px; padding-top:5px; ">
                                                        <asp:Label ID="lblModuleID" runat="server" Visible="false" Text='<%#Eval("ID") %>' ></asp:Label>
                                                            <img src='<%#IIf(Eval("Checked")=True,"../images/chkBox_chkd.jpg","../images/chkBox_unChkd.jpg") %>' alt="" /> <asp:CheckBox ID="chkModules" Enabled="false"  runat="server" Visible="false"  Checked='<%#Bind("Checked")%>' />
                                                            <span title='<%#Eval("Title")%>' style="font-size:11px; font-weight:lighter;  "><%#Functions.StringTruncate(Eval("Title"), 45)%></span>
                                                        </td>
                                                        <td style="width:168px; padding-left:4px; padding-top:5px; "> 
                                                            <b><asp:Label ID="lblModulePrice" runat="server" Text='<%#String.Format("{0:C}",Eval("Price"))%>'></asp:Label></b> 
                                                       &nbsp;<span style="font-size:x-small; ">/store per month</span></td>
                                                        <td style="width:170px; padding-left:8px; padding-top:5px;">  
                                                           <asp:Label ID="lblBillToModule" runat="server" Text='<%#Functions.BillToOption(Eval("BillTo"))%>'></asp:Label>&nbsp;<span style=" font-weight:bold  ;display:<%#IIf(Eval("BillTo")=3,"inline","none") %>">(corporate will pay&nbsp;<%#Eval("CorporatePay")%>%)</span>
                                                       </td>
                                                    </tr>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                <tr>
                                                     <td  colspan="3" style="height:3px; border:0px;">&nbsp;</td>
                                                </tr>
                                                    </table>
                                                </FooterTemplate> 
                                            </asp:Repeater> 
                                          </td> 
                                 </tr>
                          </ItemTemplate> 
                             <FooterTemplate>
                                     </table>
                           </FooterTemplate> 
                          </asp:Repeater>
                          </td>
                           </ItemTemplate> 
                          <FooterTemplate> 
                            </table>
                           </FooterTemplate> 
                          </asp:Repeater>
                           <asp:Literal ID="ltlNoRecordsFound" runat="server" Visible="false" Text="<center><font color='#000000' face='Arial, Helvetica, sans-serif'>No Record(s) Found!</font> &nbsp; </center> "></asp:Literal>
                      </div>                                                        
                    </td>
                      <asp:ObjectDataSource ID="odsProductsModules" runat="server"
                       TypeName="Portal.BLL.NSProducts" SelectMethod ="GetProductsAndModules">
                       <SelectParameters >
                       <asp:QueryStringParameter Name="ClientID" QueryStringField="ClientID" Type="Int32"  />
                       </SelectParameters>
                       </asp:ObjectDataSource>
                  </tr>
         </table>       
    </div>
    </form>
</body>
</html>
