<%@ Control Language="VB" AutoEventWireup="false" CodeFile="VitalInformationFloatingDiv.ascx.vb" Inherits="MyNetsolace_Controls_VitalInformationFloatingDiv" %>
 <asp:HiddenField ID="hdnClientID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnFranchiseID" runat="server" Value="0" />   
<div align="left" id="FrachiseDetail" style="display: inline; position: absolute; overflow: auto; height:99%; width:348px; top:0px; left: -320px;">
               <asp:Button ID="btnRebind" runat="server" Text="" style="display:none;" />
               
                    <asp:FormView 
                runat="server"
                ID="fvLeadVitals"
                Width="100%"
                Height="100%"
                DataSourceID="sdsFranchiseVitals"
                CellPadding="0"
                CellSpacing="0"  >
                <ItemTemplate>
                    <table  style="width:100%; height:100%;" border="0" cellpadding="0" cellspacing="0">
                  <tr style="border-color:#FFFFFF;">
                    <td>
                      <table style="width:100%; height:100%;border-right:1px solid #609BD3;border-bottom:1px solid #609BD3;"  border="0" align="center" cellpadding="0" cellspacing="0" class="blueSubTableTD">
                        <tr> 
                            <th style="height:20px;" align="left">
    	                        &nbsp;Vital Information
	                        </th>
	                    </tr>
                        <tr> 
                             <td>                              
                                <div style="height: 100%; width: 100%; overflow:auto; "> 
                                    <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                                      <tr  > 
                                        <td  style="width:40%;" >&nbsp;Franchise #:</td>
                                        <td style="height:20px;width:60%;"  align="left" >                                        
                                            <%#IIf(Eval("IsCorporate") = true, Eval("StoreNick"), Functions.GetStoreName(Eval("Status")) & Eval("StoreNumber"))%>
                                        </td>
                                    </tr>
                                    <tr  > 
                                        <td >&nbsp;Corp Name:</td>
                                        <td   align="left" style="height:20px; font-weight:bold;">  
                                         <%# Eval("CorporateName") %> &nbsp;                                                   
                                        </td>
                                    </tr>              
                                    <tr style="<%# IIf(Eval("IsCorporate") = true,"display:none;","display:inline;") %>" > 
                                        <td >&nbsp;Status:</td>
                                        <td style="height:20px;"> 
                                         &nbsp;<%#Functions.GetStoreStatus1(Eval("Status"), Eval("IsSuspended"),Eval("IsAbandon"))%>
                                        </td>
                                    </tr>              
                                    <tr  style="<%# IIf(Eval("IsCorporate") = true,"display:none;","display:inline;") %>"> 
                                      <td >&nbsp;<%#IIf(Eval("Status") = 1, "Req. Opening Date:", "Opening Date:")%>
                                      </td>
                                      <td style="height:20px;">                                     
                                      &nbsp;<%#IIf(Eval("Status") = 1, CType(Eval("ReqOpeningDate"), DateTime).ToString("MMM dd, yyyy"), CType(Eval("GrandOpening"), DateTime).ToString("MMM dd, yyyy"))%>
                                      </td>
                                    </tr>
                                    <tr style='<%# IIF(Eval("Status") = 1 ,"Display:inline" , "Display:none") %>'  > 
                                        <td  >&nbsp;Days since signed:</td>
                                        <td  style="height:20px;">  
                                        &nbsp;<%# DateDiff(DateInterval.Day,Ctype(Eval("DateSigned"),DateTime),DateTime.Now) %> 
                                        </td>
                                    </tr>    
									<tr> 
                                        <td >&nbsp;Time Zone:</td>
                                        <td style="height:20px;"  >
                                           &nbsp;<span title='<%# Eval("TimeZone") %>'><%# Functions.StringTruncate(Eval("TimeZone"),25) %></span>
                                        </td>
                                    </tr>                                         
                                    <tr> 
                                        <td >&nbsp;Franchise &nbsp;Coordinator:</td>
                                        <td style="height:20px;"  >
                                           &nbsp;<span title='<%# Eval("FranchiseCoordinator") %>'><%# Eval("FranchiseCoordinator") %></span>
                                        </td>
                                    </tr>                                                                             
                                    
                                    <tr> 
                                        <th style="height:20px;font-weight:bold;border-top:1 solid #7DA4CD;" colspan="2" align="left">&nbsp;Contacts</th>
                                    </tr>              
                                    <tr> 
                                        <td  >&nbsp;Address:</td>
                                        <td style="height:40px;" >
                                            <%# Eval("Address") & "<br /> " &   Eval("City") & ", " & Eval("StateCode") & "&nbsp;" & Eval("Zip") %> &nbsp;</td>
                                    </tr>              
                                    <tr  > 
                                        <td >&nbsp;Telephone:</td>
                                        <td style="height:20px;">
                                            <%# Eval("Phone") %>&nbsp;
                                        </td>
                                    </tr>                                  
                                    <tr  > 
                                        <td >&nbsp;Fax: </td>
                                        <td style="height:20px;">

                                            <%# Eval("Fax") %>&nbsp;
                                        </td>
                                    </tr>                                  
                                    <tr> 
                                        <td >&nbsp;Email:</td>
                                        <td style="height:20px;"  >
                                            <a href="mailto:<%# Eval("CorporateEmail") %>" title="<%# Eval("CorporateEmail") %>"> 
                                             <%# Functions.StringTruncate(Eval("CorporateEmail"),25) %></a>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:Repeater ID="rptClientProduct" runat="server" DataSourceID="odsClientProduct">
                                            <HeaderTemplate>
                                                <table cellpadding="0" cellspacing="0" border="0" class="blueSubTableTD" style="width:100%; padding-left:2px;border-bottom:0px;">
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <tr>
                                                    <th align="left" style="height:20px;font-weight:bold;border-top:0 solid #7DA4CD;width:100%;white-space:nowrap;"><%#Eval("Title")%>&nbsp;</th>
                                                    <th>&nbsp;</th>
                                                </tr>    
                                                <tr>
                                                    <td colspan="2">
                                                        <asp:FormView ID="fvProductDetail" runat="server" DataSource='<%# Container.DataItem.CreateChildView("ProductDetail") %>' Width="100%" OnDataBound="fvProductDetail_DataBound">
                                                        <ItemTemplate>
                                                            <table cellpadding="0" cellspacing="0" border="0" class="blueSubTableTD" style="width:100%; padding-left:2px;border:0px;">                                                                
                                                            <asp:HiddenField ID = "hdnProductID" Value='<%#Eval("ProductID") %>' runat="server" />
                                                                <tr style='<%# IIF((Eval("ProductID") <> Portal.BLL.Enumeration.NSProductIDs.BackUp AND Eval("ProductID") <> Portal.BLL.Enumeration.NSProductIDs.ESETAntiVirus) ,"Display:inline" , "Display:none") %>'>
                                                                    <td style="width:40%;">IP :</td>
                                                                    <td style="height:20px; width:60%;"><%#Eval("IP")%>&nbsp;</td>
                                                                </tr>
                                                                 <tr style='<%# IIF((Eval("ProductID") <> Portal.BLL.Enumeration.NSProductIDs.BackUp AND Eval("ProductID") <> Portal.BLL.Enumeration.NSProductIDs.ESETAntiVirus) ,"Display:inline" , "Display:none") %>'>
                                                                    <td>Version :</td>
                                                                    <td style="height:20px;"><%#Eval("Version")%>&nbsp;</td>
                                                                </tr>
                                                                 <tr style='<%# IIF((Eval("ProductID") <> Portal.BLL.Enumeration.NSProductIDs.BackUp AND Eval("ProductID") <> Portal.BLL.Enumeration.NSProductIDs.ESETAntiVirus) ,"Display:inline" , "Display:none") %>'>
                                                                    <td>Last Updated :</td>
                                                                    <td style="height:20px;"><%#String.Format("{0: MMM dd, yyyy hh:mm tt}", Eval("LastUpdateDate"))%>&nbsp;<i><span style='<%# IIF(String.Format("{0: MMM dd, yyyy hh:mm tt}",Eval("LastUpdateDate")) = "" ,"Display:none" , "Display:inline") %>'>(EST)</span></i></td>
                                                                </tr>                                                               
                                                                 <tr style='<%# IIF(Eval("ProductID") <> Portal.BLL.Enumeration.NSProductIDs.BackUp ,"Display:inline" , "Display:none") %>'>
                                                                    <td><%#IIf(Eval("ProductID") = Portal.BLL.Enumeration.NSProductIDs.SMS_X, "# of Terminals:", "Licenses #:")%></td>
                                                                    <td style="height:20px;"><%#Eval("NoOfLicenses")%>&nbsp;</td>
                                                                </tr>
                                                                <tr style='<%# IIF( Eval("ProductID") = Portal.BLL.Enumeration.NSProductIDs.SMS Or Eval("ProductID") = Portal.BLL.Enumeration.NSProductIDs.Qs Or Eval("ProductID") = Portal.BLL.Enumeration.NSProductIDs.SMS_X ,"Display:inline" , "Display:none") %>'>
                                                                    <td nowrap>CCPayment Gateway :</td>
                                                                    <td style="height:20px;"><%# Eval("CCPaymentGateway")%>&nbsp;</td>
                                                                </tr>                                                                 
                                                                    <tr style='<%# IIF(Eval("ProductID") = Portal.BLL.Enumeration.NSProductIDs.BackUp ,"Display:inline" , "Display:none") %>'>
                                                                        <td>On Back Up :</td>
                                                                        <td style="height:20px;"><img src='<%# IIF(Eval("OnSupport")= True, "../images/chkBox_Chkd.jpg","../images/chkBox_unChkd.jpg") %>' /></td>
                                                                    </tr>
                                                                     <tr style='<%# IIF(Eval("ProductID") = Portal.BLL.Enumeration.NSProductIDs.BackUp ,"Display:inline" , "Display:none") %>'>
                                                                        <td>Start Date :</td>
                                                                        <td style="height:20px;"><%#String.Format("{0: MMMM dd, yyyy}", Eval("SupportStartDate"))%>&nbsp;</td>
                                                                    </tr>
                                                                     <tr style='<%# IIF(Eval("ProductID") = Portal.BLL.Enumeration.NSProductIDs.BackUp ,"Display:inline" , "Display:none") %>'>
                                                                        <td>End Date :</td>
                                                                        <td style="height:20px;"><%#String.Format("{0: MMMM dd, yyyy}", Eval("SupportEnddate"))%>&nbsp;</td>
                                                                    </tr>
                                                                     <tr style='<%# IIF(Eval("ProductID") = Portal.BLL.Enumeration.NSProductIDs.ESETAntiVirus ,"Display:inline" , "Display:none") %>'>
                                                                        <td>Start Date :</td>
                                                                        <td style="height:20px;"><%#String.Format("{0: MMMM dd, yyyy}", Eval("SupportStartDate"))%>&nbsp;</td>
                                                                    </tr>
                                                                     <tr style='<%# IIF(Eval("ProductID") = Portal.BLL.Enumeration.NSProductIDs.ESETAntiVirus ,"Display:inline" , "Display:none") %>'>
                                                                        <td>End Date :</td>
                                                                        <td style="height:20px;"><%#String.Format("{0: MMMM dd, yyyy}", Eval("SupportEnddate"))%>&nbsp;</td>
                                                                    </tr>
                                                                <asp:Repeater ID="rptClientProduct" runat="server" DataSource='<%# Container.DataItem.CreateChildView("SubProductDetail") %>'>
                                                                <ItemTemplate>
                                                                    <tr>
                                                                        <th align="left" colspan="2"  style="height:20px;font-weight:bold;border:0; width:100%;filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=#D1E6F9,endColorStr=#ffffff);"><img src="../images/arrows.gif" />&nbsp;<%#Eval("Title")%>&nbsp;</th>
                                                                    </tr> 
                                                                    <tr>
                                                                        <td>On Support :</td>
                                                                        <td style="height:20px;"><img src='<%# IIF(Eval("OnSupport")= True, "../images/chkBox_Chkd.jpg","../images/chkBox_unChkd.jpg") %>' /></td>
                                                                    </tr>
                                                                     <tr>
                                                                        <td>Support Start Date :</td>
                                                                        <td style="height:20px;"><%#String.Format("{0: MMMM dd, yyyy}", Eval("SupportStartDate"))%>&nbsp;</td>
                                                                    </tr>
                                                                     <tr>
                                                                        <td>Support End Date :</td>
                                                                        <td style="height:20px;"><%#String.Format("{0: MMMM dd, yyyy}", Eval("SupportEnddate"))%>&nbsp;</td>
                                                                    </tr>
                                                                </ItemTemplate> 
                                                                </asp:Repeater>                                                                                                                        
                                                            </table>
                                                        </ItemTemplate>
                                                        </asp:FormView>
                                                    </td>
                                                </Tr>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                </table>
                                            </FooterTemplate>
                                            </asp:Repeater>
                                        </td>
                                    </tr>   
                                    <asp:ObjectDataSource ID="odsClientProduct" runat="server"  SelectMethod="GetClientProductsByFranchiseID" TypeName="Portal.BLL.NSProducts">
                                    <SelectParameters>
                                        <asp:ControlParameter  Name="ClientID" Type="Int32" ControlID="hdnClientID" PropertyName="Value" />
                                        <asp:ControlParameter  Name="FranchiseID" Type="Int32" ControlID="hdnFranchiseID" PropertyName="Value" />
                                    </SelectParameters>
                                    </asp:ObjectDataSource>                                                                       
                                </table>
                            </div>
                        </td>
                      </tr>
                  </table>            
                </td>
                    <td  valign="top" style="width:27px;">
                          <table width="27" style="height:100%;" border="0" align="left" cellpadding="0" cellspacing="0">
                            <tr>
                              <td style="height:219px;cursor:pointer;" colspan="2" id="OpenProfile" ><img src="../images/vital_info_open.gif" onmouseout="this.src='../images/vital_info_open.gif'" onmouseover="this.src='../images/vital_info_open_over.gif'" onclick="showHideVital();" name="img_vital_info" width="27" height="219" border="0" alt="" /></td>
                              <td style="height:219px;display:none;cursor:pointer;" colspan="2" id="CloseProfile" ><img src="../images/vital_info_close.gif" onmouseout="this.src='../images/vital_info_close.gif'" onmouseover="this.src='../images/vital_info_close_over.gif'" onclick="showHideVital();" name="img_vital_info" width="27" height="219" border="0" alt="" /></td>
                            </tr>
                            <tr>
                              <td style="background-image:url(../images/vital_info_bottom_bg.gif);width:8px;border-bottom:1px solid #609BD3;" >&nbsp;</td>
                              <td style="width:19px;">&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                  </tr>
                </table>
                </ItemTemplate>
                </asp:FormView>
                   
                <asp:ObjectDataSource ID="sdsFranchiseVitals" runat="server" 
                    SelectMethod="FranchiseGetByID"
                    TypeName="Portal.BLL.Franchises">
                    <SelectParameters>
                      <asp:ControlParameter  Name="ClientID" Type="Int32" ControlID="hdnClientID" PropertyName="Value" />
                      <asp:ControlParameter  Name="FranchiseID" Type="Int32" ControlID="hdnFranchiseID" PropertyName="Value" />                      
                    </SelectParameters>
            </asp:ObjectDataSource>              
             </div>
<script language="javascript" type="text/javascript"  >     
  function rebinddata()
  { 
    showHideVital();
    document.getElementById('<%= btnRebind.ClientID %>').click(); 
  }  
      
   
</script>
