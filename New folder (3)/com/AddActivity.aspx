<%@ Page Language="VB" EnableEventValidation="false" AutoEventWireup="false" CodeFile="AddActivity.aspx.vb" ValidateRequest="false" Theme="Default" Inherits="AddActivity" %>
<%@ Register Src="VitalInformationFloatingDiv.ascx" TagName="VitalInformationFloatingDiv"
    TagPrefix="CsCtrl" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Add Activity</title>
      <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
      <script type="text/javascript" src="../scripts/functions.js"></script>
      <style type="text/css">
        .ActivityHeader td
        {
            background-color:#BDE7BD;
            font-size:12px;
            font-weight:bold;
            padding:3px;
            height:31px;
            border-bottom:1 solid #609BD3;  
        }
      </style>
</head>
<body style="margin:0px;width:100%;height:100%;" >
 <form id="form1" runat="server" > 
  <div id="divDisable" class="modalBackground" ></div>
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" AsyncPostBackTimeout="300"></asp:ScriptManager>
        <iframe id="modalBackgroundDiv" runat="server" marginheight="0" marginwidth="0" scrolling="no" frameborder="0" style="height:100%;width:100%;z-index:09;position:absolute;filter:progid:DXImageTransform.Microsoft.alpha(opacity=50);opacity:0.5;" src="../BlankPage.htm"></iframe>        
        <asp:HiddenField ID="hdnSelectedModule" Value="0" runat="server" />
        <div id="DivProductStatus" style="display:none;border:solid 2px #A31A19; position:absolute;width:350px;height:200px;z-index:10;background-color:#FECCCB;left:50px; top:0px;">
	      <table style="height:100%;width:100%;" cellpadding="0" border="0" cellspacing="0"    >
	           <tr>    
		          <td align="left" style="padding-left:5px;width:90%;">
			          <span title="Franchise Termination Alert" style="color:black;font-weight:bold;font-size:12px;"></span>
		          </td>
		          <td  style="height:24px;cursor:pointer;">
			          <img src="../images/btn_close.gif" style="float:right;" alt="Close Window" onClick="javascript:GoBackToNewActivity();" />
		          </td>
	           </tr>
	           <tr valign="top">
		         <td colspan="2" align="center"  style="width:100%;font-size:13px;">
		            <table style="width:100%;height:100%;" cellpadding="0" cellspacing="0">
		                <tr>
		                    <td style="width:40px;padding:5px;" valign="top"><img src="../images/icn_suspendedSupportAlert.jpg" /></td>
		                    <td valign="top" style="padding-top:5px;">
		                        <table border="0" cellpadding="3" cellspacing="0" style="width:100%;text-align:left;font-size:12px;">
				                  <tr style="font-weight:bold;">
					                 <td><span id="DivProductStatusMessage" runat="server">TERMINATED STORE!</span></td>
				                  </tr>
				                   <tr style="font-size:11px;color:#7E6A67;">
					                 <td><span id="DivProductStatusMessageDeatil" runat="server"></span></td>
				                  </tr>
				                </table>    
		                    </td>
		                </tr>
		            </table>			    
		         </td>
	           </tr>
	           <tr>
		        <td colspan="2" align="center" style="background-color:#FDA29F;border-top:solid 1px #B8474F;height:35px; vertical-align:middle;">
		          <input class="Btn3D" id="btnCancle" onBlur="this.focus();" style="width: 80px" onClick="javascript:GoBackToNewActivity();" type="button" name="btnCancle" value="OK" />
		        </td>
	          </tr>
	      </table>
	    </div>     
        <div id="ProductSelectorDiv" runat="server" style="display:none;border:solid 2px #609BD3;background-color:#F1F7FB; position:absolute;width:370px;z-index:10;height:200px;">
		    <table style="height:100%;width:100%;" cellpadding="0" border="0" cellspacing="0"   >		        
		        <tr>  
			        <td colspan="2" style="width:100%;padding:10px 0px 5px 25px;">
			            <table style="width:100%;height:100%;" cellpadding="0" cellspacing="0">
			                <tr valign="middle">                                    
                                <td colspan="2" style="height:30px;" class="SimpleExSmallBold">
                                    Please select the following options to continue
                                </td>
                            </tr>
                            <tr><td colspan="2">&nbsp;</td></tr>
			                <tr valign="middle">                                    
                                <td valign="top" style="padding-top:4px;height:25px;width:70px;" class="SimpleExSmall">Related To:<span class="RequiredField">*</span></td>
                                <td>                            
                                    <asp:DropDownList ID="ddlDivProducts" 
                                        CssClass="SmallGreenTextBox" 
                                        ValidationGroup="ProductSelector"
                                        runat="server" 
                                        Width="200px" 
                                        AutoPostBack="false" 
                                        DataSourceID="sdsDivProducts"
                                        onchange="ddlDivProducts_OnChange(this)" 
                                        DataTextField="Title"
                                        DataValueField="ID" >
                                    </asp:DropDownList>
                                    <asp:SqlDataSource 
                                        ID="sdsDivProducts" 
                                        runat="server" 
                                        ConnectionString="<%$ConnectionStrings:PortalConnectionString%>"
                                        SelectCommand="NS_Products_GetAllForModules_ByClientID" 
                                        SelectCommandType="StoredProcedure"                                             
                                        DataSourceMode="DataReader">                                        
                                          <SelectParameters>
                                           <asp:ControlParameter ControlID="hdnClientID" Name="ClientID" PropertyName="Value" />
                                          </SelectParameters>
                                       </asp:SqlDataSource> 
                                    <asp:CompareValidator ID="CompareValidator3" runat="server" 
                                        ControlToValidate="ddlDivProducts"
                                        ValidationGroup="ProductSelector"
                                        Operator="GreaterThan"
                                        Display="Dynamic"
                                        style="vertical-align:top;"
                                        ErrorMessage="<br/>Select Related To"
                                        ValueToCompare="0"                                        
                                        CssClass="ErrorMessage">
                                    </asp:CompareValidator>
                                </td>
                            </tr>                            
                            <tr id="divModule">
                                <td valign="top" style="padding-top:3px;" class="SimpleExSmall">Issue:<span class="RequiredField">*</span></td>
                                <td style="height:25px;">                                    
                                    <asp:DropDownList ID="ddlModule" 
                                        runat="server"
                                        CssClass="SmallGreenTextBox"                                        
                                        onchange="ddlModule_OnChange(this)" 
                                        ValidationGroup="ProductSelector"                                        
                                        Width="200px">
                                        <asp:ListItem Text="Select.." Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:CustomValidator
                                        ID="cvDivModuleValidate"
                                        runat="server"
                                        ValidationGroup="ProductSelector"
                                        ClientValidationFunction="DivModuleValidate"
                                        ControlToValidate="ddlModule" 
                                        style="vertical-align:top;"
                                        display="Dynamic"
                                        CssClass="ErrorMessage"
                                        ErrorMessage="<br/>Select issue">
                                     </asp:CustomValidator>
                                </td>                                                                
                            </tr>                             
                            <tr><td colspan="2">&nbsp;</td></tr>
			            </table>
			        </td>
			    </tr>
			    <tr>
		            <td style="text-align:center;padding:4px;border-top:solid 1px #609BD3;background-color:#C2DCEE;">
		                <asp:Button ValidationGroup="ProductSelector" OnClientClick="return ValidateDivProductSelection();" ID="btnDivProductSelect" runat="server" CssClass="Btn3D" Text="GO" />&nbsp;
		                <button id="btnCancel" onBlur="document.getElementById('ddlDivProducts').focus();" name="btnCancel" class="Btn3D"  style="width:80px;" onClick="javascript:window.location='Franchise_Inbox.aspx?FranchiseID=<%= Request.QueryString("FranchiseID").ToString() %>&ClientID=<%= Request.QueryString("ClientID").ToString() %>';" >Cancel</button>
		            </td>   
	            </tr>
		    </table>
        </div>				  
        <table style="width:100%;height:100%; background-color:#BADCFC;" border="0" cellspacing="0" cellpadding="0"  class="MainTable">
         <tr>
             <td style="width:27px;">
                 <asp:UpdatePanel ID="update1" runat="server" UpdateMode="Always" RenderMode="Block" >
                 <ContentTemplate>           
                    <CsCtrl:VitalInformationFloatingDiv ID="VitalInformationFloatingDiv" runat="server" />
                 </ContentTemplate>
               </asp:UpdatePanel>
             </td>
             <td style="padding:5px" onClick="if (blnShowed == true){showHideVital();}"> 
                <table   style="width:100%;height:100%;background-color:#FFFFFF;border:1 solid #609BD3; " class="Table"   border="0" align="center" cellpadding="0" cellspacing="0" > 
                    <tr>
                       <td style="height:85px;">      
                       <asp:HiddenField ID="hdnID" runat="server" Value="0" />
                       <asp:HiddenField ID="PrevPage" runat="server" Value="0" />  
                       <asp:HiddenField ID="hdnFranchiseID" runat="server" Value="0" />
                       <asp:HiddenField ID="hdnClientID" runat="server" Value="0" />
                       <asp:HiddenField ID="hdnIsClose" runat="server" Value="0" />
                       <asp:HiddenField ID="hdnDueDate" runat="server" Value="0" />
                          <table style="width:100%;height:25%; border-color:#7391B9;"  border="0" align="center" cellpadding="0" cellspacing="0" class="Table"  >
                              <tr style="background-color:#DDE4EE;">
                                    <td style="height:31px;" colspan="6">	
                                       <table cellpadding="0" cellspacing="0" width="100%">
                                            <tr class="ActivityHeader">
                                                <td colspan="2" class="SimpleBold">
                                                    &nbsp;<asp:Label ID="lblTitle" runat="server" Text="Add Activity" ></asp:Label> &nbsp;(&nbsp;<asp:Label runat="server" ID="lblFranchiseName" />&nbsp;)
                                                </td>
                                                <td style="width:100px;" align="right">
                                                  <asp:DropDownList ID="ddlFranchiseContact1" 
                                                            runat="server"
                                                            DataSourceID="odsContact"
                                                            AutoPostBack="false" 
                                                            DataTextField="Name"  
                                                            CssClass="SmallGreenTextBox" 
                                                            DataValueField="ID" Width="130px" >
                                                     </asp:DropDownList>
                                                     <asp:ObjectDataSource ID="odsContact" runat="server"
                                                        OldValuesParameterFormatString="original_{0}"
                                                        SelectMethod="FranchisesContactByID"
                                                        TypeName="Portal.BLL.Franchises"> 
                                                        <SelectParameters>
                                                              <asp:ControlParameter Name="ClientID" DefaultValue="1"  ControlID="hdnClientID" Type="int32" PropertyName="value" />
                                                              <asp:ControlParameter  Name="FranchiseID" Type="Int32" ControlID="hdnFranchiseID" PropertyName="Value" />
                                                        </SelectParameters>
                                                     </asp:ObjectDataSource>
                                                </td>
                                                <td style="width:100px;">
                                                    <div style="width:110px; height:20px; " class="LeadDetailButton" onClick="Javascript:showContact();">
                                                        &nbsp;View <img  src="../images/blt_resetfilters.gif" align="absmiddle" width="10" height="10" style="border:0px;" alt="" />
                                                    </div>
                                                </td>
                                                <td style="width:1px;padding-right:3px;">
                                                    <img align="absMiddle"  height="20" src="../images/pixel_skyBlue.jpg" width="2" alt="" />
                                                </td>
                                                <td style="width:105px;padding-right:5px;">
                                                     <asp:LinkButton ID="LinkButton1" runat="server" CssClass="HomeButton">
                                                        <div style="width:110px;" class="LeadDetailButton" onClick="javascript:window.location='AddMessage.aspx?FranchiseID=<%= Request.QueryString("FranchiseID").ToString() %>&ClientID=<%= Request.QueryString("ClientID").ToString() %>'; return false;">
                                                            &nbsp;&nbsp; New Message
                                                            <img  src="../images/blt_resetfilters.gif" align="absmiddle" width="10" height="10" style="border:0px;" alt="" />
                                                        </div>
                                                     </asp:LinkButton>
                                                 </td>   
                                            </tr>
                                       </table>
                                    </td>
                               </tr>
                              <tr style="border-color:#F5F5F5; background-color:#DEF7D6;">
                                    <td  style="width:2%; height:25px;"></td>
                                    <td style="width:8%;" class="SimpleExSmall">Contact:<span class="RequiredField">*</span></td>
                                    <td style="width:36%;" >
                                    <asp:DropDownList ID="ddlFranchiseContact" 
                                            runat="server"
                                            AutoPostBack="false"
                                            DataSourceID="sdsContacts" 
                                            DataTextField="Name"  
                                            CssClass="SmallGreenTextBox" 
                                            DataValueField="ID" Width="150px" >
                                     </asp:DropDownList>
                                     <asp:ObjectDataSource ID="sdsContacts" runat="server"
                                        OldValuesParameterFormatString="original_{0}"
                                        SelectMethod="FranchisesContactByID"
                                        TypeName="Portal.BLL.Franchises"> 
                                        <SelectParameters>
                                              <asp:ControlParameter  Name="ClientID" Type="Int32" ControlID="hdnClientID" PropertyName="Value" />
                                              <asp:ControlParameter  Name="FranchiseID" Type="Int32" ControlID="hdnFranchiseID" PropertyName="Value" />
                                        </SelectParameters>
                                     </asp:ObjectDataSource>
                                      <asp:CompareValidator ID="valContact" 
                                        runat="server" 
                                        ControlToValidate="ddlFranchiseContact"
                                        Operator="GreaterThan"
                                        ValueToCompare="0" 
                                        Display="Dynamic"
                                        ErrorMessage="Select contact"
                                        CssClass="ErrorMessage" >
                                     </asp:CompareValidator>
                                    </td>
                                    <td style="width:1%;"></td>
                                    <td style="width:13%;" class="SimpleExSmall">Type:<span class="RequiredField">*</span></td>
                                    <td style="width:41%;" >
                                     <asp:DropDownList ID="ddlType" 
                                            runat="server"
                                            AutoPostBack="false"
                                            CssClass="SmallGreenTextBox"
                                            Width="150px" >
                                            <asp:ListItem Text="Select..." Value="0" ></asp:ListItem>
                                           <%-- <asp:ListItem Text="HelpDesk" Value="1" />
                                            <asp:ListItem Text="Message" Value="2" />                                           
                                            <asp:ListItem Text="NewStoreStage" Value="9" />
                                            <asp:ListItem Text="MKTCalendar" Value="10" />
                                            <asp:ListItem Text="EdibleIdea" Value="11" />
                                            <asp:ListItem Text="Discussion" Value="12" />
                                            <asp:ListItem Text="ProfileUpdate" Value="13" />
                                            <asp:ListItem Text="StoreUpdate" Value="14" />
                                            <asp:ListItem Text="CoordinatorChange" Value="15" />
                                            <asp:ListItem Text="Finance" Value="16" />
                                            <asp:ListItem Text="AdditionalArea" Value="17" />--%>
                                            <asp:ListItem Text="Email" Value="4" />
                                            <asp:ListItem Text="Fax" Value="5" />
                                            <asp:ListItem Text="Meeting" Value="6" />
                                            <asp:ListItem Text="Letter" Value="7" />                                            
                                            <asp:ListItem Text="Webinar" Value="21" />
                                            <asp:ListItem Text="Incoming Call" Value="22" />
                                            <asp:ListItem Text="Outgoing Call" Value="23" />
                                            <asp:ListItem Text="Escalation from EA" Value="24" />
                                            <asp:ListItem Text="Internal" Value="25" />
                                     </asp:DropDownList>
                                     <asp:CompareValidator ID="valType" 
                                        runat="server" 
                                        ControlToValidate="ddlType"
                                        Operator="GreaterThan"
                                        ValueToCompare="0" 
                                        Display="Dynamic"
                                        ErrorMessage="Select activity type"
                                        CssClass="ErrorMessage" >
                                     </asp:CompareValidator>
                                    </td>
                              </tr>                    
                              <tr > 
                                    <td height="1"  colspan="6"><img  src="../images/spacer.gif" width="1" height="1" alt="" /></td>
                              </tr>
                              <tr style="border-color:#F5F5F5; background-color:#DEF7D6;" valign="middle">
                                    <td ></td>
                                    <td  style="height:25px;" class="SimpleExSmall">Date: </td>
                                    <td>                            
                                        <strong><asp:Label  ID="txtDueDate" runat="server" Width="150px"></asp:Label></strong>
                                    </td>
                                    <td ></td>
                                    <td  class="SimpleExSmall">Topic:<span class="RequiredField">*</span></td>
                                    <td >
                                     <asp:DropDownList runat="server" ID="ddlTopic"
                                            Width="150px"
                                            Enabled="true"
                                            SkinID="SmallTextCombo"
                                            DataSourceID="sdsTopics" 
                                            DataTextField="Topic"
                                            DataValueField="ID"
                                            AutoPostBack="false" >
                                          </asp:DropDownList>
                                          <asp:SqlDataSource ID="sdsTopics" 
                                              runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                              SelectCommand="Activities_GetTopics" 
                                              SelectCommandType="StoredProcedure"
                                              DataSourceMode="DataReader">
                                          </asp:SqlDataSource>
                                     <asp:CompareValidator ID="valSubType" 
                                        runat="server" 
                                        ControlToValidate="ddlTopic"
                                        Operator="GreaterThan"
                                        ErrorMessage="Select activity sub type"
                                        ValueToCompare="0" 
                                        Display="Dynamic"
                                        CssClass="ErrorMessage" >
                                     </asp:CompareValidator>
                                    </td>                                                            
                              </tr>
                              <tr > 
                                    <td  colspan="6"><img  src="../images/spacer.gif" width="1" height="1" /></td>
                              </tr>
                              <tr style="border-color:#F5F5F5; background-color:#DEF7D6;">
                                    <td ></td>
                                     <td  class="SimpleExSmall">Time:</td>
                                     <td>
                                     <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional" RenderMode="block">
                                      <ContentTemplate>
                                         <strong>                                         
                                             <div id="divTime" runat="server" >                           
                                            <asp:DropDownList ID="ddlHoursNotes"  runat="server"                            
                                            CssClass="SmallGreenTextBox"  
                                            AutoPostBack="false" >
                                            <asp:ListItem Text="00" Value="0" Selected="True" ></asp:ListItem>
                                            <asp:ListItem Text="01" Value="1"  ></asp:ListItem>
                                            <asp:ListItem Text="02" Value="2"  ></asp:ListItem>
                                            <asp:ListItem Text="03" Value="3"  ></asp:ListItem>
                                            <asp:ListItem Text="04" Value="4"  ></asp:ListItem>
                                            <asp:ListItem Text="05" Value="5"  ></asp:ListItem>
                                            <asp:ListItem Text="06" Value="6"  ></asp:ListItem>
                                            <asp:ListItem Text="07" Value="7"  ></asp:ListItem>
                                            <asp:ListItem Text="08" Value="8"  ></asp:ListItem>
                                            <asp:ListItem Text="09" Value="9"  ></asp:ListItem>
                                            <asp:ListItem Text="10" Value="10"  ></asp:ListItem>
                                            <asp:ListItem Text="11" Value="11"  ></asp:ListItem>
                                            </asp:DropDownList>
                                            :
                                            <asp:DropDownList ID="ddlMinutesNotes"  runat="server"                           
                                            CssClass="SmallGreenTextBox"  
                                            AutoPostBack="false" >
                                            <asp:ListItem Text="00" Value="0" Selected="True" ></asp:ListItem>
                                            <asp:ListItem Text="01" Value="1"  ></asp:ListItem>
                                            <asp:ListItem Text="02" Value="2"  ></asp:ListItem>
                                            <asp:ListItem Text="03" Value="3"  ></asp:ListItem>
                                            <asp:ListItem Text="04" Value="4"  ></asp:ListItem>
                                            <asp:ListItem Text="05" Value="5"  ></asp:ListItem>
                                            <asp:ListItem Text="06" Value="6"  ></asp:ListItem>
                                            <asp:ListItem Text="07" Value="7"  ></asp:ListItem>
                                            <asp:ListItem Text="08" Value="8"  ></asp:ListItem>
                                            <asp:ListItem Text="09" Value="9"  ></asp:ListItem>
                                            <asp:ListItem Text="10" Value="10"  ></asp:ListItem>
                                            <asp:ListItem Text="11" Value="11"  ></asp:ListItem>
                                            <asp:ListItem Text="12" Value="12"  ></asp:ListItem>
                                            <asp:ListItem Text="13" Value="13"  ></asp:ListItem>
                                            <asp:ListItem Text="14" Value="14"  ></asp:ListItem>
                                            <asp:ListItem Text="15" Value="15"  ></asp:ListItem>
                                            <asp:ListItem Text="16" Value="16"  ></asp:ListItem>
                                            <asp:ListItem Text="17" Value="17"  ></asp:ListItem>
                                            <asp:ListItem Text="18" Value="18"  ></asp:ListItem>
                                            <asp:ListItem Text="19" Value="19"  ></asp:ListItem>
                                            <asp:ListItem Text="20" Value="20"  ></asp:ListItem>
                                            <asp:ListItem Text="21" Value="21"  ></asp:ListItem>
                                            <asp:ListItem Text="22" Value="22"  ></asp:ListItem>
                                            <asp:ListItem Text="23" Value="23"  ></asp:ListItem>
                                            <asp:ListItem Text="24" Value="24"  ></asp:ListItem>
                                            <asp:ListItem Text="25" Value="25"  ></asp:ListItem>
                                            <asp:ListItem Text="26" Value="26"  ></asp:ListItem>
                                            <asp:ListItem Text="27" Value="27"  ></asp:ListItem>
                                            <asp:ListItem Text="28" Value="28"  ></asp:ListItem>
                                            <asp:ListItem Text="29" Value="29"  ></asp:ListItem>
                                            <asp:ListItem Text="30" Value="30"  ></asp:ListItem>
                                            <asp:ListItem Text="31" Value="31"  ></asp:ListItem>
                                            <asp:ListItem Text="32" Value="32"  ></asp:ListItem>
                                            <asp:ListItem Text="33" Value="33"  ></asp:ListItem>
                                            <asp:ListItem Text="34" Value="34"  ></asp:ListItem>
                                            <asp:ListItem Text="35" Value="35"  ></asp:ListItem>
                                            <asp:ListItem Text="36" Value="36"  ></asp:ListItem>
                                            <asp:ListItem Text="37" Value="37"  ></asp:ListItem>
                                            <asp:ListItem Text="38" Value="38"  ></asp:ListItem>
                                            <asp:ListItem Text="39" Value="39"  ></asp:ListItem>
                                            <asp:ListItem Text="40" Value="40"  ></asp:ListItem>
                                            <asp:ListItem Text="41" Value="41"  ></asp:ListItem>
                                            <asp:ListItem Text="42" Value="42"  ></asp:ListItem>
                                            <asp:ListItem Text="43" Value="43"  ></asp:ListItem>
                                            <asp:ListItem Text="44" Value="44"  ></asp:ListItem>
                                            <asp:ListItem Text="45" Value="45"  ></asp:ListItem>
                                            <asp:ListItem Text="46" Value="46"  ></asp:ListItem>
                                            <asp:ListItem Text="47" Value="47"  ></asp:ListItem>
                                            <asp:ListItem Text="48" Value="48"  ></asp:ListItem>
                                            <asp:ListItem Text="49" Value="49"  ></asp:ListItem>
                                            <asp:ListItem Text="50" Value="50"  ></asp:ListItem>
                                            <asp:ListItem Text="51" Value="51"  ></asp:ListItem>
                                            <asp:ListItem Text="52" Value="52"  ></asp:ListItem>
                                            <asp:ListItem Text="53" Value="53"  ></asp:ListItem>
                                            <asp:ListItem Text="54" Value="54"  ></asp:ListItem>
                                            <asp:ListItem Text="55" Value="55"  ></asp:ListItem>
                                            <asp:ListItem Text="56" Value="56"  ></asp:ListItem>
                                            <asp:ListItem Text="57" Value="57"  ></asp:ListItem>
                                            <asp:ListItem Text="58" Value="58"  ></asp:ListItem>
                                            <asp:ListItem Text="59" Value="59"  ></asp:ListItem>                                                    
                                            </asp:DropDownList>                                                                                                       
                                                   (HH:MM) <asp:CustomValidator ID="cvTimeSpent" runat="server" ControlToValidate="ddlHoursNotes" 
                                                                Display="Dynamic" ErrorMessage="Select Time Spent" ClientValidationFunction="ValidateTimeSpent">
                                                            </asp:CustomValidator>       
                                         </div>  
                                        </strong>
                                       </ContentTemplate>
                                     </asp:UpdatePanel>                           
                                    </td>                                                            
                                    <td ></td>
                                    <td  style="height:25px;" class="SimpleExSmall">Related To:<span class="RequiredField">*</span></td>
                                    <td>                            
                                        <asp:DropDownList ID="ddlProducts" 
                                            CssClass="SmallGreenTextBox" 
                                            runat="server" 
                                            Width="150px" 
                                            AutoPostBack="false" 
                                            onchange="ddlDivProducts_OnChange(this)"
                                            DataSourceID="SDS_Products" 
                                            DataTextField="Title" 
                                            DataValueField="ID" >
                                        </asp:DropDownList>
                                        <asp:SqlDataSource 
                                            ID="SDS_Products" 
                                            runat="server" 
                                            ConnectionString="<%$ConnectionStrings:PortalConnectionString%>"
                                            SelectCommand="NS_Products_GetAllForModules_ByClientID" 
                                            SelectCommandType="StoredProcedure"                                             
                                            DataSourceMode="DataReader">                                            
                                          <SelectParameters>
                                           <asp:ControlParameter ControlID="hdnClientID" Name="ClientID" PropertyName="Value" />
                                          </SelectParameters>
                                       </asp:SqlDataSource> 
                                        <asp:CompareValidator ID="CV_ddlProducts" runat="server" 
                                            ControlToValidate="ddlProducts"
                                            Operator="GreaterThan"
                                            ErrorMessage="Select Related To"
                                            ValueToCompare="0" 
                                            Display="Dynamic"
                                            CssClass="ErrorMessage">
                                     </asp:CompareValidator>
                                    </td>
                                    
                               </tr>                               
                               <tr > 
                                    <td  colspan="6"><img  src="../images/spacer.gif" width="1" height="1" alt="" /></td>
                               </tr>
                               <tr style="border-color:#F5F5F5; background-color:#DEF7D6;" valign="middle">
                                    <td ></td>
                                    <td class="SimpleExSmall">Priority:<span class="RequiredField">*</span></td>
                                    <td>
                                      <asp:DropDownList ID="ddlPriority" 
                                            runat="server"                                 
                                            AutoPostBack="false"                                                                                                            
                                            CssClass="SmallGreenTextBox" 
                                            Width="150px" >
                                            <asp:ListItem Text="Select..." Value="0" ></asp:ListItem>
                                            <asp:ListItem Text="Low" Value="1"  Selected="True" />
                                            <asp:ListItem Text="Minimal" Value="2"/>
                                            <asp:ListItem Text="Moderate" Value="3" />
                                            <asp:ListItem Text="High" Value="4" />
                                            <asp:ListItem Text="Critical" Value="5" />
                                     </asp:DropDownList>
                                     <asp:CompareValidator ID="CompareValidator1" 
                                        runat="server" 
                                        ControlToValidate="ddlPriority"
                                        Operator="GreaterThan"
                                        ErrorMessage="Select Priority"
                                        ValueToCompare="0" 
                                        Display="Dynamic"
                                        CssClass="ErrorMessage" >
                                     </asp:CompareValidator>
                                    </td>                                    
                                    <td ></td>
                                    <td class="SimpleExSmall"><span id="SpanModule">Issue:<span class="RequiredField">*</span></span></td>
                                    <td>                                        
                                        <asp:DropDownList 
                                            ID="ddlProductModules" 
                                            runat="server"
                                            CssClass="SmallGreenTextBox" 
                                            onchange="SetSelectedModuleID(this);"                                            
                                            Width="150px">
                                            <asp:ListItem Text="Select.." Value="0"></asp:ListItem>
                                         </asp:DropDownList>
                                         <asp:CustomValidator
                                            ID="cvValidateModule"
                                            runat="server"
                                            ClientValidationFunction="ValidateModule"
                                            ControlToValidate="ddlProductModules"
                                            CssClass="ErrorMessage"
                                            ErrorMessage="Select issue">
                                         </asp:CustomValidator>
                                    </td>                                                                
                              </tr>
                               
                               <tr > 
                                    <td  colspan="6"><img  src="../images/spacer.gif" width="1" height="1" alt="" /></td>
                               </tr>
                               <tr style="border-color:#E9E9E9; background-color:#BDE7BD">
                                    <td style="height:25px;"></td>
                                    <td class="SimpleExSmall" >Subject:<span class="RequiredField">*</span></td>
                                    <td  colspan="3" >
                                        <asp:TextBox runat="server" ID="txtActivitySubject" Text="" MaxLength="500"  CssClass="SmallGreenTextBox" Width="80%" />
                                        <asp:RegularExpressionValidator 
                                        ID="revDescrpHtml" 
                                        runat="server" 
                                        ControlToValidate="txtActivitySubject"
                                        ErrorMessage="<br>Enter valid subject." ValidationExpression="^[^<>]*$" CssClass="RequiredField" Display="Dynamic">
                                        </asp:RegularExpressionValidator>
                                        <asp:RequiredFieldValidator ID="valSubject" runat="server"
                                            ControlToValidate="txtActivitySubject"
                                            ErrorMessage="<br>Enter Subject"
                                            Display="Dynamic"
                                            CssClass="ErrorMessage" >
                                        </asp:RequiredFieldValidator>
                                    </td>                                                 
                                    <td style="white-space:nowrap;" class="SimpleExSmallBold" align="right"  >
                                        &nbsp;
                                        <asp:LinkButton   ID="btnAddNotes" runat="server" CausesValidation="false" style="padding:4px; font-size:11px; width:90px;height:18px;" oncontextmenu="return false;" Font-Underline="true" Text="Add Attachments" OnClientClick="showAttachFiles(); return false;"  />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    </td>                                  
                               </tr>
                               <tr > 
                                    <td  colspan="6"><img  src="../images/spacer.gif" width="1" height="1" alt="" /></td>
                               </tr>                                                                        
                            </table>                                                                          
                      </td>
                    </tr>
                    <tr>
                       <td style="width: 100%;height:100%;">  
                          <div style="width: 100%;height:100%;vertical-align:top;"  class="DivScroll" >  
                             <table style="width: 100%;height:100%;" cellpadding="0" cellspacing="0" border="0"> 
                                 <tr class="SimpleExSmallBold" id="trFiles" style="display:none;border:none;">
                                    <td style="height:25px;" colspan="4">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td style="border:none;width:5%;" rowspan="2" align="center" ><img src="../images/ico_attachment.gif" align="middle" alt="attach" /></td>
                                                <td style="border:none;" id="tdFiles"></td>
                                            </tr>                                           
                                        </table> 
                                    </td>
                                  </tr>
                                   <tr>
                                        <td style="border:none;" colspan="4" align="left" >
                                         <asp:RequiredFieldValidator ID="valDescription" runat="server"
                                            ControlToValidate="txtDescription"
                                            ErrorMessage="&nbsp;Enter Description"
                                            Display="Dynamic"
                                            CssClass="ErrorMessage" >
                                        </asp:RequiredFieldValidator>  
                                        <asp:TextBox runat="server" 
                                             ID="txtDescription" 
                                             TextMode="MultiLine" 
                                             Font-Size="11px"
                                             Width="100%"
                                             Height="100%"
                                             Text="">
                                         </asp:TextBox> 
                                                                                          
                                        </td>                                                
                                    </tr>                                                 
                            </table>  
                         </div>            
                      </td>
                    </tr>          
                    <tr style="background-color:#BDE7BD;">
                       <td style="border-top:1 solid #609BD3;" >
                          <table style="width:100%; height:100%" border="0" cellpadding="0" cellspacing="0" >
                            <tr style="height:31;" >
                                <td  style="width:2%;"></td>
                                <td class="SimpleExSmall" style="width:15%">
                                    <div runat="server"  id="divStatus">&nbsp;Status:<span class="RequiredField">*</span>&nbsp;                           
                                        <asp:DropDownList ID="ddlActivityStatus"   
                                            CssClass="SmallGreenTextBox"                                             
                                            runat="server">
                                            <asp:ListItem Value="0" Text="Select..." ></asp:ListItem>
                                            <asp:ListItem Value="1" Text="Not Started" Selected="True" ></asp:ListItem>
                                            <asp:ListItem Value="2" Text="In Progress" ></asp:ListItem>
                                            <asp:ListItem Value="4" Text="Waiting For" ></asp:ListItem>
                                            <asp:ListItem Value="3" Text="Completed" ></asp:ListItem>                                
                                        </asp:DropDownList>
                                         <asp:CompareValidator ID="valStatus" 
                                                runat="server" 
                                                ControlToValidate="ddlActivityStatus"
                                                ValueToCompare="0"
                                                Operator="GreaterThan"                                                                                           
                                                ErrorMessage="Select status"
                                                Display="Dynamic"
                                                CssClass="ErrorMessage">
                                           </asp:CompareValidator>
                                   </div>                                   
                               </td>
                                <td class="SimpleExSmall" style="width:58%;">
                                    <div  runat="server" id="waitingfor" style="display:none;">
                                    <asp:DropDownList ID="ddlWaitingFor" 
                                        runat="server" 
                                        ValidationGroup="WaitingFor"                                         
                                        CausesValidation="true"   
                                        OnDataBound="ddlWaitingFor_DataBound" 
                                        DataSourceID="sdsWaitingFor" 
                                        DataTextField="Name"  
                                        CssClass="SmallGreenTextBox" 
                                        DataValueField="ID"  Width="50%" >
                                    </asp:DropDownList>
                                        <asp:SqlDataSource ID="sdsWaitingFor" runat="server"
                                            ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>" 
                                            SelectCommand="Activities_GetAllWaitingFor_ByFranchiseID" 
                                            SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="hdnClientID" Name="ClientID" PropertyName="Value" />
                                                <asp:ControlParameter ControlID="hdnFranchiseID" Name="FranchiseID" PropertyName="Value" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                         <asp:CustomValidator 
                                            ID="valwaitingfor"
                                            ClientValidationFunction="CheckWaitingFor"
                                            ErrorMessage="Select Waiting For"
                                            CssClass="RequiredField"
                                            runat="server"
                                            Display="Dynamic" >                                                                    
                                      </asp:CustomValidator>
                                   </div>
                                  </td>
                                 <td style="width:25%;" align="right">                             
                                    <asp:Button ID="btnSave" runat="server"  CssClass="Btn3D" CausesValidation="True" Text="Save" Width="80px" />&nbsp;&nbsp;
                                    <button id="btnBack" name="btnBack" class="Btn3D"  style="width:80px;" onClick="javascript:window.location='Franchise_Inbox.aspx?FranchiseID=<%= Request.QueryString("FranchiseID").ToString() %>&ClientID=<%= Request.QueryString("ClientID").ToString() %>';" >Cancel</button>&nbsp;&nbsp;                                         
                                 </td>
                             </tr>
                           </table>
                         </td>
                    </tr>      
                </table>
             </td>
         </tr>
       </table>
    </div>
    <div align="center" id="Attachment" style="display:none; border:0px solid black; position:absolute;left:25%; top:20%; width: 450px; height: 230px;">
        <table align="center" width="100%" cellpadding="0" cellspacing="0" class="MainAlertDiv">
	        <tr>
	          <th style="height:21px;" align="left" valign="middle">&nbsp;Add - Attachments</th>
	          <th align="right" valign="top"><img src="../images/closebox2.gif" onClick="OnAttachmentSubmit(); return false;" style="cursor:pointer;" alt="" /></th>
	        </tr>
	        <tr>
	           <td style="width:100%;" valign="top" colspan="2">
		            <table  align="center" width="100%" cellpadding="0" cellspacing="0" class="MainAlertDiv" style="border:none;">
			            <tr>
			                <td align="center" style="height:25px;" colspan="2">Attach Files!</td>
			            </tr>
                        <tr>
                            <td></td>
                            <td  style="height:25px;" >
                                <font size="2" face="verdana, Arial, Helvetica, sans-serif">
                                    &nbsp;File 1: <span id="spnFile1">
                                                        <asp:FileUpload id="file1" Runat="server" style="width:330px;" />
                                                        <asp:RegularExpressionValidator id="REV_file1" runat="server" 
                                                            ErrorMessage="Attachment must be a .jpg, .jpeg, .png, .gif, .doc, .pdf, .txt, .rtf or .zip file" 
                                                            ValidationExpression="^.*(.txt|.zip|.doc|.jpg|.jpeg|.png|.gif|.doc|.docx|.pdf|.rtf|.xls|.xlsx|.rar|.TXT|.ZIP|.DOC|.DOCX|.XLS|.XLSX|.JPG|.JPEG|.PNG|.GIF|.DOC|.DOCX|.XLS|.XLSX|.RAR|.PDF|.RTF)$"  
                                                            Display="Dynamic"                                           
                                                            ControlToValidate="file1">
                                                        </asp:RegularExpressionValidator>
                                                  </span><br/>
                                    &nbsp;File 2: <span id="spnFile2">
                                                        <asp:FileUpload id="file2" Runat="server" style="width:330px;" />
                                                        <asp:RegularExpressionValidator 
                                                            id="REV_file2" runat="server" 
                                                            ErrorMessage="Attachment must be a .jpg, .jpeg, .png, .gif, .doc, .pdf, .txt, .rtf or .zip file" 
                                                            ValidationExpression="^.*(.txt|.zip|.doc|.jpg|.jpeg|.png|.gif|.doc|.docx|.pdf|.rtf|.xls|.xlsx|.rar|.TXT|.ZIP|.DOC|.DOCX|.XLS|.XLSX|.JPG|.JPEG|.PNG|.GIF|.DOC|.DOCX|.XLS|.XLSX|.RAR|.PDF|.RTF)$"  
                                                            Display="Dynamic"                                           
                                                            ControlToValidate="file2">
                                                        </asp:RegularExpressionValidator>
                                                  </span><br />
                                    &nbsp;File 3: <span id="spnFile3">
                                                        <asp:FileUpload id="file3"  Runat="server" style="width:330px;" />
                                                        <asp:RegularExpressionValidator 
                                                            id="REV_file3" runat="server" 
                                                            ErrorMessage="Attachment must be a .jpg, .jpeg, .png, .gif, .doc, .pdf, .txt, .rtf or .zip file" 
                                                            ValidationExpression="^.*(.txt|.zip|.doc|.jpg|.jpeg|.png|.gif|.doc|.docx|.pdf|.rtf|.xls|.xlsx|.rar|.TXT|.ZIP|.DOC|.DOCX|.XLS|.XLSX|.JPG|.JPEG|.PNG|.GIF|.DOC|.DOCX|.XLS|.XLSX|.RAR|.PDF|.RTF)$"  
                                                            Display="Dynamic"                                                                                                       
                                                            ControlToValidate="file3">
                                                        </asp:RegularExpressionValidator>
                                                   </span>
                                 </font>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height:30px;" align="center">
                                <input type="button" value="OK" style="width:80px;"  onclick="OnAttachmentSubmit();"  class="btnExtraSimple" />&nbsp;
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
	   </table>
    </div>  
    <div id="DivOption" runat="server"  style="display:none;border:solid 1px #000000; position:absolute; width:600px;  height:220px;top:15%; left:10%; z-index:1;"    >
          <table style="height:100%;" cellpadding="0" border="0" cellspacing="0"   >
           <tr>    
              <td align="left" style="border-bottom:solid 1px #000000;padding-top:4px; padding-left:1em;vertical-align:middle; background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%;">
                  <label id="Label1" title="Notes"    style="color:White;height:100%; overflow:auto; font-weight:bold;"  >Contact Information</label>
              </td>
              <td  style="border-bottom:solid 1px #000000;background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%; height:28px; cursor:pointer;">
                  <img src="../images/win_btn_close_black.jpg" style="float:right;" alt="Close Window" onClick="DivOptionHide();" />
              </td>               
           </tr>
           <tr valign="top">                
             <td colspan="2" style="height:100%; padding:0px; font-size:12px; background-color:White;" >   
             <iframe name="IfContactProfile" runat="server" id="IfContactProfile" src="Blank.aspx" style="margin: 0px;width:100%;height:100%;border:0px" scrolling="no" frameborder="0"></iframe>
             </td>
           </tr>            
          </table>
        </div> 
        <script language="javascript" type="text/javascript">
            <asp:Literal ID="ltrlModulesArray" runat="server"></asp:Literal>
            
            var NotApplicable = <asp:Literal ID="ltrlNotApplicable" runat="server"></asp:Literal>
            
            function SetModulesDisplay(display){
                document.getElementById('SpanModule').style.display=display;
                document.getElementById('divModule').style.display=display;
                document.getElementById('<%=ddlProductModules.ClientID%>').style.display=display;                
            }
            function GoBackToNewActivity(){
                var FranchiseID = document.getElementById('<%= hdnFranchiseID.ClientID %>').value;
                var ClientID = document.getElementById('<%= hdnClientID.ClientID %>').value;
                window.location='Franchise_Inbox.aspx?FranchiseID='+FranchiseID+'&ClientID='+ClientID;
            }
	        function ShowAndSetDivDimentions(DivID)
	        {
	          var DivToShow = document.getElementById(DivID);
	          DivToShow.style.display = 'inline';
	          var DivHeight = DivToShow.offsetHeight;
	          var DivWidth = DivToShow.offsetWidth;
	          DivToShow.style.top = (parseInt(document.body.offsetHeight) - parseInt(DivHeight))/2 - 30;
	          DivToShow.style.left = (parseInt(document.body.offsetWidth) - parseInt(DivWidth))/2;
	        }
        	
	        function ValidateDivProductSelection(){           
             var ddlDivProducts = document.getElementById('<%= ddlDivProducts.ClientID %>');            
             var selectedText = ddlDivProducts.options[ddlDivProducts.selectedIndex].text;        
           
           if(selectedText != "Not Applicable")
           {
           ValidateModules(true);
           }
                if (Page_ClientValidate('ProductSelector')){                    
                    document.getElementById("ProductSelectorDiv").style.display='none';               
                    return true;
                }
                return false;
            }
            
            function ddlDivProducts_OnChange(ddlDivProducts){
                var ddlProducts = document.getElementById('<%= ddlProducts.ClientID %>');
                ddlProducts.value = ddlDivProducts.value;
                LoadProductModulesByProductID(ddlProducts.value,0);
                 ValidateModules(false);
            }
            function ValidateModules(boolValidate){
                var validator = document.getElementById('<%=cvDivModuleValidate.ClientID %>');
                var cvValidateModule = document.getElementById('<%=cvValidateModule.ClientID %>');
                ValidatorEnable(validator, boolValidate); 
                ValidatorEnable(cvValidateModule, boolValidate);
            }
            
            function LoadProductModulesByProductID(ProductID, ModuleValueToSelect){
                var ddlDivModule = document.getElementById('<%= ddlModule.ClientID %>');
                var ddlProductModules = document.getElementById('<%= ddlProductModules.ClientID %>');
                
                if(parseInt(ProductID) == parseInt(NotApplicable)){                        
                    SetModulesDisplay('none');
                    ValidateModules(false);
                    return;
                }else{
                    SetModulesDisplay('inline');                    
                    ValidateModules(true);
                }
                
                //Clear Dropdownlist                
                ddlDivModule.options.length = 0;
                ddlProductModules.options.length = 0;

                for(var i=0; i < arrModules.length; i++){
                    var moduleData = arrModules[i].split('_');
                    if (moduleData.length == 3){                        
                        if( i == 0){
                            AddOptionToDDL(ddlDivModule,"0","Select..");
                            AddOptionToDDL(ddlProductModules,"0","Select..");
                        }
                        
                        if(parseInt(ProductID) == parseInt(moduleData[0])){
                            AddOptionToDDL(ddlDivModule,moduleData[1],moduleData[2]);
                            AddOptionToDDL(ddlProductModules,moduleData[1],moduleData[2]);                        
                        }
                    }
                }
                                
                if(ddlProductModules.options.length == 1){
                    AddOptionToDDL(ddlDivModule,NotApplicable,"Not Applicable");
                    AddOptionToDDL(ddlProductModules,NotApplicable,"Not Applicable");
                }
                
                ddlDivModule.value = ModuleValueToSelect;
                ddlProductModules.value = ModuleValueToSelect;
                document.getElementById('<%=hdnSelectedModule.ClientID %>').value = ModuleValueToSelect;
            }
            
            function AddOptionToDDL(ddl, value, text){
                var index = ddl.length;
                ddl.options[index] = new Option();
                ddl.options[index].value = value;
                ddl.options[index].text = text;
            }
            
            function ValidateModule(oSrc,oArg){            
                var moduleID = document.getElementById('<%=hdnSelectedModule.ClientID %>').value;
                if(moduleID == 0){
                    oArg.IsValid = false;
                }else{
                    oArg.IsValid = true;
                }
            }

            function DivModuleValidate(oSrc,oArg){            
                var moduleID = document.getElementById('<%=hdnSelectedModule.ClientID %>').value;
                if(moduleID == 0){
                    oArg.IsValid = false;
                }else{
                    oArg.IsValid = true;
                }
            }

            function ddlModule_OnChange(ddlDivModule){
                var ddlProductModules = document.getElementById('<%= ddlProductModules.ClientID %>');
                ddlProductModules.value = ddlDivModule.value;
                SetSelectedModuleID(ddlDivModule);
            }
            
            function SetSelectedModuleID(ddl){
                document.getElementById('<%=hdnSelectedModule.ClientID %>').value = ddl.value;
                ValidateModules(true)
            }
            
            function validateSameFiles(oSrc, args){
                if ( (getElement('<%= File1.ClientID %>').value == getElement('<%= File2.ClientID %>').value && getElement('<%= File1.ClientID %>').value != '' && getElement('<%= File2.ClientID %>').value != '') || 
                     (getElement('<%= File1.ClientID %>').value == getElement('<%= File3.ClientID %>').value && getElement('<%= File1.ClientID %>').value != '' && getElement('<%= File3.ClientID %>').value != '') || 
                     (getElement('<%= File2.ClientID %>').value == getElement('<%= File3.ClientID %>').value && getElement('<%= File2.ClientID %>').value != '' && getElement('<%= File3.ClientID %>').value != '') )
                   args.IsValid = false
                else
                   args.IsValid = true;
            }
            
            function validateFiles(oSrc, args){
                if ( (getElement('<%= File1.ClientID %>').value == '') && 
                     (getElement('<%= File2.ClientID %>').value == '') &&
                     (getElement('<%= File3.ClientID %>').value == '') )
                    args.IsValid = false
                else
                    args.IsValid = true;
            }
          
            function OpenWindow(LeadID)
            {
                window.open('../BlankPage.aspx?Page=lead/PrintLead&PageTitle=Print Lead&LeadID='+LeadID,'','dialogHeight=750px,menubar=1,dialogWidth=600px,status=1');
            
            }

          
               function activityStateChange()
                    {

                    var ActivityState = document.getElementById('<%=ddlActivityStatus.ClientID %>')
                    var WaitingFor = document.getElementById('<%=waitingfor.ClientID %>')

                      
                     
	                    if (ActivityState.value == "4")
	                        {
		                    WaitingFor.style.display = 'inline';
		                    return false;
		                    }
                    		
	                    else
		                    {
		                    WaitingFor.style.display = 'none';				            
		                     return true;
		                    }
                    		
                    }   
                    
               function CheckWaitingFor(oSrc, args)
                    {
                      var ActivityState = document.getElementById('<%=ddlActivityStatus.ClientID %>')
                      var WaitingFor = document.getElementById('<%=ddlWaitingFor.ClientID %>')             
                        if (ActivityState.value == "4")
                            {	                   
	                            if(WaitingFor.value == "0")
	                            {
	                            args.IsValid = false;
	                            }
	                            else 
	                            {
	                            args.IsValid = true;		                
	                            }		            
	                        }            		
                        else
	                        {    		            	            
	                         args.IsValid = true;		               
	                        }
                    }
                    
              function showAttachFiles()
            {
                document.getElementById("Attachment").style.display='inline';
                setWindowedControlsVisibility(window, 'hidden');
            }
            
            function OnAttachmentSubmit()
            {
              var Fupload = document.getElementById('<%=File1.ClientID%>')
                var count = 0 
                if (Fupload.value != '' )
                {
                count = count+1
                }
                Fupload = document.getElementById('<%=File2.ClientID%>')
                if (Fupload.value != '' )
                {
                count = count+1
                }
                Fupload = document.getElementById('<%=File3.ClientID%>')
                if (Fupload.value != '' )
                {
                count = count+1
                }       
                document.getElementById('AttachmentTotal').innerHTML = count       
	            document.getElementById("Attachment").style.display='none';
	        }

         function textCounter(field)
             {
           
                if (field.value.length > 500)        
                field.value = field.value.substring(0, 500);
            }
            
         function ShowUpdateMessage()
             {
                document.getElementById('spnUpdateMessage').style.display = 'inline' ;       
                setTimeout('HideUpdateMessage()' , 3000)
             }
             
         function HideUpdateMessage()
             {       
                document.getElementById('spnUpdateMessage').style.display = 'none' ;
             }
             
             
             
             function OnAttachmentSubmit(flagCancel)
                 {
	                //var FileExp = new RegExp("^.*(.txt|.zip|.doc|.jpg|.jpeg|.png|.gif|.doc|.docx|.pdf|.rtf|.xls|.xlsx|.rar|.TXT|.ZIP|.DOC|.DOCX|.XLS|.XLSX|.JPG|.JPEG|.PNG|.GIF|.DOC|.DOCX|.XLS|.XLSX|.RAR|.PDF|.RTF)$"); 
	                if (flagCancel == 1)
	                {
		                ResetAttachment3();ResetAttachment2();ResetAttachment1();
	                }
        //	        else 
        //	        {
        //	             if(!(FileExp.test(trim(document.getElementById('<%=File1.ClientID%>').value))))
        //	             {
        //	             ResetAttachment1();
        //	             }
        //	             if(!(FileExp.test(trim(document.getElementById('<%=File2.ClientID%>').value))))
        //	             {
        //	             ResetAttachment2();
        //	             }
        //	             if(!(FileExp.test(trim(document.getElementById('<%=File3.ClientID%>').value))))
        //	             {
        //	             ResetAttachment3();
        //	             }
        //	         
        //	        }        
                	
	                getElement('Attachment').style.display = 'none';
	                try{setWindowedControlsVisibility(window, 'visible');}catch(e){}	
	                var strFiles = '';	        
	                if (trim(document.getElementById('<%=File1.ClientID%>').value) != '')
		                strFiles += '<table style=\'display:inline;\' class=SimpleExSmallBold><tr><td rowspan=2 style=\'border:none;\'>&nbsp;&nbsp;</td><td style=\'border:none;\'>'+trimFileName(getElement('file1').value.substr(getElement('file1').value.lastIndexOf("\\")+1))+'</td></tr><tr><td style=\'cursor:pointer;font-size:7px;border:none;\' align=right onClick=\'ResetAttachment1();OnAttachmentSubmit(0);\'>[ R E M O V E ]</td></tr></table>' ;
	                if (trim(document.getElementById('<%=File2.ClientID%>').value) != '')
		                strFiles += '<table style=\'display:inline;\' class=SimpleExSmallBold><tr><td rowspan=2 style=\'border:none;\'>&nbsp;&nbsp;</td><td style=\'border:none;\'>'+trimFileName(getElement('file2').value.substr(getElement('file2').value.lastIndexOf("\\")+1))+'</td></tr><tr><td style=\'cursor:pointer;font-size:7px;border:none;\' align=right onClick=\'ResetAttachment2();OnAttachmentSubmit(0);\'>[ R E M O V E ]</td></tr></table>' ;
	                if (trim(document.getElementById('<%=File3.ClientID%>').value) != '')
		                strFiles += '<table style=\'display:inline;\' class=SimpleExSmallBold><tr><td rowspan=2 style=\'border:none;\'>&nbsp;&nbsp;</td><td style=\'border:none;\'>'+trimFileName(getElement('file3').value.substr(getElement('file3').value.lastIndexOf("\\")+1))+'</td></tr><tr><td style=\'cursor:pointer;font-size:7px;border:none;\' align=right onClick=\'ResetAttachment3();OnAttachmentSubmit(0);\'>[ R E M O V E ]</td></tr></table>' ;
                	
	                if (strFiles == '')
	                {
		                getElement('trFiles').style.display = 'none';
		                getElement('tdFiles').innerHTML = '';
	                }
	                else
	                {
		                getElement('trFiles').style.display = 'inline';
		                getElement('tdFiles').innerHTML = strFiles;	
	                }
	                strFiles = '';
                 }
                function trimFileName(strFileName)
                 {
	                    if (strFileName.length > 20)
		                    return strFileName.substr(0,20)+' ...';
	                    else
		                    return strFileName;
                 }
             function ResetAttachment2()
                 {
//                    var Fupload = document.getElementById('<%=File2.ClientID%>');
//                    var TD = Fupload.parentElement ;
//                    var str = TD.innerHTML;
//                    str = str.replace(Fupload.value,'');
//                    TD.innerHTML = str;
					form1.file2.parentNode.innerHTML = form1.file2.parentNode.innerHTML;
                 } 
             function ResetAttachment1()
                 {
                 
//                    var Fupload = document.getElementById('<%=File1.ClientID%>');
//                    var TD = Fupload.parentElement ;
//                    var str = TD.innerHTML;
//                    str = str.replace(Fupload.value,'');
//                    TD.innerHTML = str;
                   form1.file1.parentNode.innerHTML = form1.file1.parentNode.innerHTML;
                 } 
           
            function ResetAttachment3()
                {
                 
//                   var Fupload = document.getElementById('<%=File3.ClientID%>');
//                   var TD = Fupload.parentElement ;
//                   var str = TD.innerHTML;
//                   str = str.replace(Fupload.value,'');
//                   TD.innerHTML = str ;
					form1.file3.parentNode.innerHTML = form1.file3.parentNode.innerHTML;
                } 
             function showContact()
             {
                    var DivOption = getElement('<%= DivOption.ClientID %>')        
                    divDisable.style.width = document.body.scrollWidth
                    divDisable.style.height = document.body.scrollHeight
                    DivOption.style.display= "inline";
                    setWindowedControlsVisibility(window,'hidden');
                    IfContactProfile.location = "ContactDetail.aspx?ClientID="+$get('<%=hdnClientID.ClientID%>').value + "&ContactID=" + $get('<%=ddlFranchiseContact1.ClientID%>').value;
                
             }
            function DivOptionHide()
            {
                    var DivOption = getElement('<%= DivOption.ClientID %>')         
                    divDisable.style.width = 0;
                    divDisable.style.height = 0;
                    DivOption.style.display= "none"; 
                    IfContactProfile.location = "Blank.aspx"                            
                    setWindowedControlsVisibility(window,'visible');
                    return false;
            }
           
           
           function ValidateTimeSpent(sender, args)
           {
                if(document.getElementById('<%= ddlHoursNotes.ClientID %>').value == 0){        
                    if(document.getElementById('<%= ddlMinutesNotes.ClientID %>').value == 0){            
                        args.IsValid=false;
                    }
                    else{
                        args.IsValid=true;
                    }
                }
                else{
                    args.IsValid=true;
                }
           }
         
        </script>   
 </form>
</body>
</html>