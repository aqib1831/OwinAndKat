			  <%@ Control Language="VB" AutoEventWireup="false" CodeFile="VitalInformationFloatingDiv.ascx.vb" Inherits="com_VitalInformationFloatingDiv" %>
  <asp:HiddenField ID="hdnClientID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnFranchiseID" runat="server" Value="0" />
    <div id="DivIFrame" runat="server"  style="display:none;border:solid 1px #000000; position:absolute; width:600px;  height:60%;top:20%; left:20%; z-index:10001;"    >
          <table style="height:100%;" cellpadding="0" border="0" cellspacing="0"   >
           <tr >    
              <td align="left" style="vertical-align:middle; border-bottom:solid 1px #000000; padding-left:1em; background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%;">
                 <asp:label ID="Label2" runat="server" Text="Synchronization Skip Key" Font-Bold="true" ForeColor="White" Font-Size="12pt" ></asp:label>
              </td>
              <td  style="border-bottom:solid 1px #000000;background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:20%; height:28px; cursor:pointer;">
                  <img src="../images/win_btn_close_black.jpg" style="float:right;" alt="Close Window" onClick="SkipReset();" />
              </td>               
           </tr>
           <tr valign="top">                
             <td colspan="2" style="height:100%; padding:0px; font-size:12px; background-color:White; border:0px;" >   
                <div id="divInnerIframe" style="overflow:auto; height:400px; width:600px; border:0px;" >   
                    <iframe name="IfSkipSync" runat="server" id="IfSkipSync" src="blank.aspx" style="margin: 0px;width:100%;height:100%;border:0px" scrolling="no" frameborder="0"></iframe>
                </div>
             </td>
           </tr>            
          </table>
        </div>
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
                        <tr > 
                             <td>
                             <asp:HiddenField ID="hdnStoreStatus" runat="server" Value='<%#Eval("Status") %>'/>
                             <asp:HiddenField ID="hdnSubStatus" runat="server" Value='<%#Eval("SubStatus") %>' />
                              <asp:HiddenField ID="hdnIsCorporate" runat="server"  Value='<%# Eval("IsCorporate") %>'/>
                                <div style="height: 100%; width: 100%; overflow:auto; "> 
                                    <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                                      <tr  > 
                                        <td  style="width:40%;" >&nbsp;Store #:</td>
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
									<tr  > 
                                        <td >&nbsp;Time Zone:</td>
                                        <td style="height:20px;"  >
                                           &nbsp;<span title='<%# Eval("TimeZone") %>'><%# Functions.StringTruncate(Eval("TimeZone"),25) %></span>
                                        </td>
                                    </tr>                                         
                                    <tr  > 
                                        <td >&nbsp;Franchise &nbsp;Coordinator:</td>
                                        <td style="height:20px;"  >
                                           &nbsp;<span title='<%# Eval("FranchiseCoordinator") %>'><%# Eval("FranchiseCoordinator") %></span>
                                        </td>
                                    </tr>                                                                             
                                    
                                    <tr> 
                                        <th style="height:20px;font-weight:bold;border-top:1 solid #7DA4CD;" colspan="2" align="left">&nbsp;Store Information</th>
                                    </tr>              
                                    <tr  > 
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
                                    <tr  > 
                                        <td >&nbsp;Email:</td>
                                        <td style="height:20px;"  >
                                            <a href="mailto:<%# Eval("CorporateEmail") %>" title="<%# Eval("CorporateEmail") %>"> 
                                             <%# Functions.StringTruncate(Eval("CorporateEmail"),25) %></a>&nbsp;
                                        </td>
                                    </tr>  
                                    <tr  runat="server" visible="false" id="trDailypin"> 
                                        <td >&nbsp;DailyPin:</td>
                                        <td style="height:20px;"  > <asp:label id="lblDailyPin" runat="server"/>&nbsp;</td>
                                    </tr>                                 
                                   
								    <tr runat="server" visible="false" id="trSynchronization">
                                        <td >&nbsp;Synchronization:</td>
                                        <td style="height:20px;">
                                            <a href="#" onclick="showSkipSyncDiv('<%#  Eval("StoreNumber")  %>','<%# Eval("CountryID") %>');">[Generate Skip Synchronization Key]</a>&nbsp;
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
                                                    <th align="left" style="height:20px;font-weight:bold;border-top:0 solid #7DA4CD;width:100%;white-space:nowrap;"><%#Eval("Title")%>&nbsp;<span style="width:20%;">&nbsp;</span><span style='<%# IIF(Eval("ID") = Portal.BLL.Enumeration.NSProductIDs.sms or Eval("ID") = Portal.BLL.Enumeration.NSProductIDs.SMS_X or Eval("ID") = Portal.BLL.Enumeration.NSProductIDs.DMenu or Eval("ID") = Portal.BLL.Enumeration.NSProductIDs.nxstep ,"Display:inline; float: right; margin-top: -12px; margin-right: 5px;" , "Display:none") %>;'><img src="../images/btn_edit.jpg" height="12"  onclick="parent.showsmsUpdate('<%#  Eval("LicenceID") %>','<%#  Eval("ID") %>');" alt="" style="text-align:right;cursor:hand;vertical-align:bottom;"  /></span>&nbsp;</th>
                                                </tr>    
                                                <tr>
                                                    <td>
                                                        <asp:FormView ID="fvProductDetail" runat="server" DataSource='<%# Container.DataItem.CreateChildView("ProductDetail") %>' Width="100%" OnDataBound="fvProductDetail_DataBound">
                                                        <ItemTemplate>
                                                            <table cellpadding="0" cellspacing="0" border="0" class="blueSubTableTD" style="width:100%; padding-left:2px;border:0px;">                                                                
                                                            <asp:HiddenField ID = "hdnProductID" Value='<%#Eval("ProductID") %>' runat="server" />
                                                                <tr style='<%# IIF((Eval("ProductID") <> Portal.BLL.Enumeration.NSProductIDs.BackUp AND Eval("ProductID") <> Portal.BLL.Enumeration.NSProductIDs.ESETAntiVirus AND IsPackageProduct(Eval("ProductID")) = false) ,"Display:inline" , "Display:none") %>'>
                                                                    <td style="width:40%;">IP :</td>
                                                                    <td style="height:20px; width:60%;"><%#Eval("IP")%>&nbsp;</td>
                                                                </tr>
                                                                 <tr style='<%# IIF((Eval("ProductID") <> Portal.BLL.Enumeration.NSProductIDs.BackUp AND Eval("ProductID") <> Portal.BLL.Enumeration.NSProductIDs.ESETAntiVirus AND IsPackageProduct(Eval("ProductID")) = false) ,"Display:inline" , "Display:none") %>'>
                                                                    <td>Version :</td>
                                                                    <td style="height:20px;"><%#Eval("Version")%>&nbsp;</td>
                                                                </tr>
                                                                 <tr style='<%# IIF((Eval("ProductID") <> Portal.BLL.Enumeration.NSProductIDs.BackUp AND Eval("ProductID") <> Portal.BLL.Enumeration.NSProductIDs.ESETAntiVirus AND IsPackageProduct(Eval("ProductID")) = false) ,"Display:inline" , "Display:none") %>'>
                                                                    <td>Last Updated :</td>
                                                                    <td style="height:20px;"><%#String.Format("{0: MMM dd, yyyy hh:mm tt}", Eval("LastUpdateDate"))%>&nbsp;<i><span style='<%# IIF(String.Format("{0: MMM dd, yyyy hh:mm tt}",Eval("LastUpdateDate")) = "" ,"Display:none" , "Display:inline") %>'>(EST)</span></i></td>
                                                                </tr>
                                                                <tr style='<%# IIF((Eval("ProductID") = Portal.BLL.Enumeration.NSProductIDs.SMS Or Eval("ProductID") = Portal.BLL.Enumeration.NSProductIDs.SMS_X) andalso Functions.CheckModuleAccess(Portal.BLL.Enumeration.Modules.SupportInfo) ,"Display:inline" , "Display:none") %>'>
                                                                    <td>Server UserName :</td>
                                                                    <td style="height:20px;"><%#Eval("ServerUserName")%>&nbsp;</td>
                                                                </tr>
                                                                 <tr style='<%# IIF((Eval("ProductID") = Portal.BLL.Enumeration.NSProductIDs.SMS Or Eval("ProductID") = Portal.BLL.Enumeration.NSProductIDs.SMS_X) andalso Functions.CheckModuleAccess(Portal.BLL.Enumeration.Modules.SupportInfo) ,"Display:inline" , "Display:none") %>'>
                                                                    <td>Server Password :</td>
                                                                    <td style="height:20px;"><%#Eval("ServerPassword")%>&nbsp;</td>
                                                                </tr>
                                                                 <tr style='<%# IIF(Eval("ProductID") <> Portal.BLL.Enumeration.NSProductIDs.BackUp AND IsPackageProduct(Eval("ProductID")) = false ,"Display:inline" , "Display:none") %>'>
                                                                    <td><%#IIf(Eval("ProductID") = Portal.BLL.Enumeration.NSProductIDs.SMS_X, "# of Terminals:", "Licenses #:")%></td>
                                                                    <td style="height:20px;"><%#Eval("NoOfLicenses")%>&nbsp;</td>
                                                                </tr>
                                                                <tr style='<%# IIF( Eval("ProductID") = Portal.BLL.Enumeration.NSProductIDs.SMS Or Eval("ProductID") = Portal.BLL.Enumeration.NSProductIDs.Qs Or Eval("ProductID") = Portal.BLL.Enumeration.NSProductIDs.SMS_X ,"Display:inline" , "Display:none") %>'>
                                                                    <td nowrap>CCPayment Gateway :</td>
                                                                    <td style="height:20px;"><%# Eval("CCPaymentGateway")%>&nbsp;</td>
                                                                </tr> 
                                                                <tr runat="server" visible='<%# iif( (eval("productid") = portal.bll.enumeration.nsproductids.sms or eval("productid") = portal.bll.enumeration.nsproductids.qs or eval("productid") = portal.bll.enumeration.nsproductids.sms_x) andalso isvaliduserforcredentialsarea() ,"true" , "false") %>'>
                                                                    <td colspan="2"> 
                                                                        <table cellpadding="0" cellspacing="0" style="width: 100%; margin-left: -2px;">
                                                                            <tr>
                                                                                <td style="width: 120px;">
                                                                                    &nbsp;Login Credentials:
                                                                                </td>
                                                                                <td style="height: 20px; padding-right: 15px;">
                                                                                    <div id="dvBtnLogin_<%#Eval("ProductID") %>" onclick="ShowLogin('<%#Eval("ProductID") %>');" style="cursor: hand; background-image: url('../images/btn_blank.jpg');
                                                                                        background-repeat: no-repeat; color: #3B3D4C; font-weight: bold; text-align: center;
                                                                                        font-size: 09px; float: right; height: 12px; width: 42; font-family: Arial; line-height: 12px;
                                                                                        position: relative;">
                                                                                        Show</div>
                                                                                    <div id="divNoLogin_<%#Eval("ProductID") %>" style="float: left; display: none;">
                                                                                        Sorry, No login credentials avaliable.</div>
                                                                                    &nbsp;
                                                                                </td>
                                                                            </tr>
                                                                            <tr id="trUserName_<%# eval("productid") %>" style="display: none;">
                                                                                <td>
                                                                                    &nbsp;UserName:</td>
                                                                                <td style="height: 20px;">
                                                                                    <asp:Label ID="lblUserName" runat="server"></asp:Label></td>
                                                                            </tr>
                                                                            <tr id="trPassword_<%# eval("productid") %>" style="display: none;">
                                                                                <td>
                                                                                    &nbsp;Password:</td>
                                                                                <td style="height: 20px;">
                                                                                    <asp:Label ID="lblPassword" runat="server"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                            <tr id="trAccess_<%# eval("productid") %>" style="display: none;">
                                                                                <td>
                                                                                    &nbsp;Access:</td>
                                                                                <td style="height: 20px;">
                                                                                    <asp:Label ID="lblAccess" runat="server"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
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
                                                                    
                                                                    <tr style='<%# IIF(IsPackageProduct(Eval("ProductID")) = true ,"Display:inline" , "Display:none") %>'>
                                                                        <td>On Support :</td>
                                                                        <td style="height:20px;"><img src='<%# IIF(Eval("OnSupport")= True, "../images/chkBox_Chkd.jpg","../images/chkBox_unChkd.jpg") %>' /></td>
                                                                    </tr>
                                                                     <tr style='<%# IIF(IsPackageProduct(Eval("ProductID")) = true ,"Display:inline" , "Display:none") %>'>
                                                                        <td>Start Date :</td>
                                                                        <td style="height:20px;"><%#String.Format("{0: MMMM dd, yyyy}", Eval("SupportStartDate"))%>&nbsp;</td>
                                                                    </tr>
                                                                     <tr style='<%# IIF(IsPackageProduct(Eval("ProductID")) = true ,"Display:inline" , "Display:none") %>'>
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
  function showSkipSyncDiv(StoreNumber,CountryID)
  {
            var FranchiseID = document.getElementById('<%= hdnFranchiseID.ClientID %>').value; 
            document.getElementById('divDisable').style.zIndex = '10000';
            var DivFram = getElement('<%= DivIFrame.ClientID %>')
            var divInnerIframe = getElement('divInnerIframe')
            IfSkipSync.location='Skip_Synchronization.aspx?StoreNumber='+StoreNumber+'&FranchiseID='+FranchiseID+'&CountryID='+CountryID;
            divInnerIframe.style.width = '350px';
            DivFram.style.width = '350px';
            divInnerIframe.style.height = '180px';
            DivFram.style.height = '180px';
            DivFram.style.left = '25%';
            
            document.getElementById('divDisable').style.width = '100%';
            document.getElementById('divDisable').style.height = '100%';
            DivFram.style.display= "inline"

   }
   function SkipReset()
   {    
        var DivFram = getElement('<%= DivIFrame.ClientID %>');        
        document.getElementById('divDisable').style.width = 0;
        document.getElementById('divDisable').style.height = 0;
        IfSkipSync.location='blank.aspx';
        DivFram.style.display= 'none';
        return false;           
  }
  function rebinddata()
  { 
    showHideVital();
    document.getElementById('<%= btnRebind.ClientID %>').click(); 
  }
  function ShowdivLoading() {
   	document.getElementById('divLoading').style.display = "block";
   }
   function HidedivLoading() {
   	moveit(0);
   	blnShowed = true;
   	document.getElementById('divLoading').style.display = "none";
   }
   function ShowLogin(id) {
    
   	document.getElementById('trUserName_'+id).style.display = "inline";
   	document.getElementById('trPassword_'+id).style.display = "inline";
   	document.getElementById('trAccess_'+id).style.display = "inline";
   	document.getElementById('dvBtnLogin_'+id).style.display = "none";
   }
   function ShowNoLogin(id) {
   document.getElementById('dvBtnLogin_'+id).style.display = "none";
   document.getElementById('divNoLogin_'+id).style.display = "inline";   
   }
</script>