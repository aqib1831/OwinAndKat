<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Releases.aspx.vb" Inherits="PM_Releases" Theme="Default" %> 

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<title>Project Managment</title>
	<link href="../../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../../scripts/functions.js" ></script>
	<meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.Fade(duration=0.2)" />
	<meta http-equiv="Page-Enter" content="progid:DXImageTransform.Microsoft.Fade(Duration=0.2)" />
</head>
<body style ="margin :0px;background-color:#E4F1F7; height:100%; width:100%;">
	<form id="form1" runat="server">  
	   <div id="divDisable" class="modalBackground" style="z-index:0;" ></div>
		<div id="DivIFrame" runat="server"  style="display:none;border:solid 1px #000000; position:absolute; width:600px;  height:60%;top:5%; left:10%; z-index:1;">
		  <table style="height:100%;" cellpadding="0" border="0" cellspacing="0"   >
		   <tr>    
			  <td align="left" style="border-bottom:solid 1px #000000; padding-left:1em; background-image:url(../../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%;">
				  <label id="lblTitle" title="Notes"   style="color:White;height:100%; overflow:auto;"  >Notes</label>
			  </td>
			  <td  style="border-bottom:solid 1px #000000;background-image:url(../../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%; height:28px; cursor:pointer;">
				  <img src="../../images/win_btn_close_black.jpg" style="float:right;" alt="Close Window" onClick="Reset()" />
			  </td>
		   </tr>
		   <tr valign="top">
			 <td colspan="2" style="height:100%; padding:10px; font-size:12px; background-color:White;" >   
				<div id="div" style="overflow:auto; height:400px; width:600px;" >   <label id="lblNotes"  ></label>   </div>
			 </td>
		   </tr>
		  </table>
		</div>
		<div>
		   <asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="300"  />
			 <asp:UpdateProgress ID="Progress1" runat="server">
			   <ProgressTemplate>
				   <div class="ProgressIndicatorDIV" >
					  <br />
					  <asp:Image ID="Image2" runat="server" ImageUrl="../../images/indicator.gif" ImageAlign="AbsMiddle" /> <span style="color:#4B92C1;font-size:14px;"><b>&nbsp;&nbsp;Loading ...</b></span>
					  <br /><br />
				   </div>
			   </ProgressTemplate>
			 </asp:UpdateProgress>  
			 <table width="100%" style="height:100%; width:100%; margin:0px; padding:0px;background-color:#E4F1F7; " cellspacing="0" cellpadding = "0" border="0"  >
			   <tr class="UnderlinedRow">
				<td  style="height:20px;background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:5px;width:50%;">
				   <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Inline">
						<ContentTemplate>
							 Current Releases&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorCount" />
							&nbsp;<span class="NonBold">(<asp:Label runat="server" ID="lblFilter" Text="all" />)</span>
						</ContentTemplate>
						<Triggers >
							  <asp:AsyncPostBackTrigger ControlID="ddlCategories" EventName="SelectedIndexChanged" />
							  <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
							  <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
						</Triggers>
					</asp:UpdatePanel>
				</td>
				<td style="background-color:#A0CDEE;text-align:right;">
					 <asp:LinkButton ID="lnkResetFilters" runat="server" CssClass="HomeButton">
						<div style="width:110px;" class="LeadDetailButton" onClick="javascript:resetFilters();">
							 Reset Filters 
							<img  src="../../images/blt_resetFilters.gif" align="absmiddle" width="10" height="10" style="border:0px;" alt=""/>
						</div>
					 </asp:LinkButton>
				</td>
			  </tr>
			  <tr>
				<td colspan="2" style="height:40px;background-color:#BADCFC;font-size:11px;">
				  <table border="0" cellpadding="0" cellspacing="0" width="100%" style="white-space:nowrap;">
					<tr>
					  <td style="padding:0px;text-align:left ; white-space:nowrap; padding-right:0em; padding-top:13px;" >
						<div  id="divNewRelease" runat="server" style="width:100px; display:none; " class="LeadDetailButton" onClick="javascript:StateSaveNewRelease();"  >
							NEW RELEASE <img align="absMiddle"  height="10" src="../../images/blt_resetFilters.gif" width="10" />
						  </div>
					  </td>
					  <td align="left" style="padding-left:5px; padding-right:5px;width:100px; ">
						<span style="font-size: 7pt; color: #7c8798">Categories</span><br />
							<asp:DropDownList 
							ID="ddlCategories" 
							runat="server" 
							SkinID="SmallTextCombo"
							DataTextField="Name" 
							DataValueField="ID" 
							AutoPostBack="True" Width="100px" DataSourceID="SDS_Categories">
						  </asp:DropDownList>
						  <asp:SqlDataSource ID="SDS_Categories" 
								   runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
								   SelectCommand="PM_Categories_AreaDeveloper_GetAll" 
								   SelectCommandType="StoredProcedure"
								   DataSourceMode="DataReader">
								   <SelectParameters>
								        <asp:SessionParameter Name="AreaDeveloperID" SessionField="MyNetsolace_AreaDeveloperID" DefaultValue="0" />
								   </SelectParameters>
							   </asp:SqlDataSource>
					 </td>
					 <td style="width:10px;text-align:center;">
						<img  src="../../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" /> 
					 </td>
					 <td style="white-space:nowrap;" align="left">
						  <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" >
							<span class="GreyTextSmall">Search</span><br />
							 <span><asp:TextBox ID="txtSearch" runat="server" onkeyup="if(CheckNoisyWord()==false) return false;" onfocus="javascript:this.value='';" MaxLength="50"    Width="100px"  SkinID="GreenSmallTextbox" />
								<asp:ImageButton ID="btnSearch" OnClientClick="if(CheckNoisyWord()==false) return false;" runat="server" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" />
							 </span>
						  </asp:Panel>
					 </td>
					 <td style="width:50%;">&nbsp;</td>
				   </tr>
				 </table>
			   </td>
			 </tr>
			 <tr style=" height:85%; width:100%;">
			   <td  colspan="2" style="background-color:#E4F1F7;  vertical-align:top; height: 85%; margin:0px;padding:0px;">
					<div style="width:100%; height:100%; overflow:auto;  background-color:#E4F1F7;border:1px solid #ACBDD5;" class="ScrollBarHomeTicket" >
					<asp:UpdatePanel ID="UpdatePanel2" 
						 runat="server" 
						 UpdateMode="Always"
						 RenderMode="Inline">
						 <ContentTemplate>
						 <asp:GridView 
							ID="gvReleases" 
							runat="server" 
							AutoGenerateColumns="False" 
							EnableTheming="True" 
							SkinID="GridViewNormal"
							AllowSorting="True" 
							DataKeyNames="ID"
							DataSourceID="ObjectDataSource1" >
							<PagerSettings Mode="Numeric" Position="Bottom" />
							 <PagerTemplate>
								  <div style="width:100%; border:0px black solid;" >
									  <table width="100%" border="0" cellpadding="0" cellspacing="0"  style="height:20px;">
										   <tr style="text-align:left;">
												 <td style="width:20%; white-space:nowrap;" align="left"  valign="middle" >
												   <span class="DarkBlueTextSmall" style="font-size:10px" >&nbsp; Page <asp:Literal id="litPageNumber" runat="server"/> of <asp:Literal id="litTotalPages"  runat="server"/></span>
												 </td>
												 <td style="width:10px; " align="right" ><img alt="" src="../../images/spacer.gif" width="15" height="1" align="absmiddle" /></td>
												 <td style="width:1px; " align="center"><img alt="" src="../../images/pixel_darkBlue.jpg" width="1" height="20" align="absmiddle" /></td>
												 <td style="width:10px;" align="right"><img alt="" src="../../images/spacer.gif" width="15" height="1" align="absmiddle" /></td>
												 <td  align="right" valign="top"> <asp:Panel ID="pnlNumber" runat="server" HorizontalAlign="Right"  ></asp:Panel> </td>
											</tr>
									  </table>  
								  </div>
							  </PagerTemplate>
								<Columns>
								   <asp:TemplateField HeaderText="Releases" SortExpression="Name" HeaderStyle-Wrap="false" >
											<ItemTemplate>
											<span style="width:10px; text-align:left;"><img  src="../../images/pm_flag.gif" style='<%#  IIf(IIf(Eval("NewReleaseDate") <> "1/1/1900",Eval("NewReleaseDate"),Eval("ReleaseDate")) <= DateTime.Now.Date, "display:inline", "display:none") %>;'  /></span>
											<span title='<%#Eval("Name")%>;' style='<%# IIf(Eval("NewReleaseDate") <= DateTime.Now.Date, "padding-left:0px;", "padding-left:10px;") %>'>
												<asp:Label ID="lblName" runat="server" style="font-weight:bold;" Text='<%# Server.HtmlEncode(Functions.StringTruncate(Functions.IfNull(Eval("Name"),""),29))%>' > ></asp:Label>
											</span>
											</ItemTemplate>
											<ItemStyle Wrap="false" />
									</asp:TemplateField>
									<asp:BoundField DataField="ReleaseDate" HeaderText="Rel Date" SortExpression="ReleaseDate" DataFormatString="{0:d}" HtmlEncode="False" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-width="60px"  ></asp:BoundField>
									<asp:BoundField DataField="NewReleaseDate" HeaderText="New Date" SortExpression="NewReleaseDate" DataFormatString="{0:d}" HtmlEncode="False" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-width="60px" />
									<asp:TemplateField HeaderText="Category" SortExpression="CategoryName" HeaderStyle-Wrap="false" >
											<ItemTemplate>
											<span title='<%#Eval("CategoryName")%>' >
												<asp:Label ID="lblCategoryName" runat="server" Text='<%# Server.HtmlEncode(Functions.StringTruncate(Functions.IfNull(Eval("CategoryName"),""),17))%>' > ></asp:Label>
											</span>
											</ItemTemplate>
									<ItemStyle Width="120px"  Wrap="false" />
								   </asp:TemplateField>
									<asp:BoundField DataField="ClientName" HeaderText="Client" SortExpression="ClientName" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" Visible="false"  />
									<asp:TemplateField Headertext="Progress" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-width="95px">
										<ItemTemplate >
										<table width="100%" cellpadding="0" border="0" cellspacing="0" >
											<tr valign="middle">
												<td style="width:45px; border-bottom:0px;">
													<div style="height:22px; background-position:left; background-image:url(../../images/progressBar.jpg); background-repeat:no-repeat;width:<%#Eval("Progress") & "%;" %>" ></div>
												</td>
												<td style="border-bottom:0px;">
													<asp:Label  Text='<%#Eval("Progress") & "%" %>' ID="lblCompleted" runat="server" />
												</td>
											</tr>
											</table>
										</ItemTemplate>
									</asp:TemplateField>
									 <asp:TemplateField  HeaderText="Status" SortExpression="Status" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-width="95px">
									<ItemTemplate> 
										<img src='<%= ConfigurationManager.AppSettings("ImagesURL") %><%#Eval("Status") %>'  />
									</ItemTemplate>
								</asp:TemplateField>  
									 <asp:TemplateField HeaderText="Action" ItemStyle-width="100px" >
										<ItemTemplate>
											<asp:LinkButton ID="lbtnEdit" runat="server" CommandArgument='<%# Eval("ID") %>' CommandName="Edit" Text="Edit  |"></asp:LinkButton>
											<asp:LinkButton ID="lbtnNotes" runat="server" CommandArgument='<%# Eval("ID") %>' CommandName="Notes" Text="  Notes  |"></asp:LinkButton>
											<asp:LinkButton ID="lbtnFeatures" runat="server" CommandArgument='<%# Eval("ID") %>' CommandName="Features" Text="  Features"></asp:LinkButton>
											<asp:LinkButton ID="lbtnDelete" runat="server" CommandArgument='<%# Eval("ID") %>' CommandName="MyDelete" Text=" |  Delete"></asp:LinkButton>
										</ItemTemplate>
										<HeaderStyle HorizontalAlign="Center" Wrap="false" />
										<ItemStyle HorizontalAlign="Center" Wrap="false" />
									</asp:TemplateField> 
									 <asp:TemplateField  Visible="False">
										<ItemTemplate>
											<asp:Label ID="lblNotes" runat="server" Text='<%# Eval("Notes") %>' ></asp:Label>
										</ItemTemplate>
									</asp:TemplateField>
								</Columns>
							</asp:GridView>
							 </ContentTemplate>
								  <Triggers >
								  <asp:AsyncPostBackTrigger ControlID="ddlCategories" EventName="SelectedIndexChanged" />
								  <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
								  <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
								  </Triggers>
							</asp:UpdatePanel>    
					  <asp:ObjectDataSource ID="ObjectDataSource1"  
							runat="server" OldValuesParameterFormatString="original_{0}" 
							SelectMethod="GetAllForMyNetsolace" 
							TypeName="Portal.BLL.PM.PM_Releases"
							EnablePaging="true"  
							SelectCountMethod="GetAllCountForMyNetsolace"
							SortParameterName="sortExpression">
							<SelectParameters>
								<asp:ControlParameter ControlID="ddlCategories" DefaultValue="1" Name="CategoryID" PropertyName="SelectedValue" Type="Int32" />
								<asp:SessionParameter  DefaultValue="1" Name="ClientID" SessionField="MyNetsolace_ClientID" Type="Int32" />
								<asp:Parameter Name="sortExpression" Type="String" />
								<asp:ControlParameter ControlID="txtsearch" DefaultValue="" Name="txtsearch" PropertyName="Text" Type="String" />
								<asp:SessionParameter SessionField="MyNetsolace_AreaDeveloperID" Type="Int32" Name="AreaDeveloperID" />
							</SelectParameters>
						</asp:ObjectDataSource>
					</div>
				   
			   </td>
			 </tr>
			 <tr style="height:20px; background-color:#BADCFC;">
				 <td align="left"  style="width:75%;" id="CustomPagerRow">
				</td>
				<td align="left"  style="width:25%;white-space:nowrap;" class="GrayHeader">
					<span style="font-size:7pt; color: #ff0000; height:7px;"><img  src="../../images/pm_flag.gif" height="7"  alt="*"/></span>
					  Delayed Releases are in Red flag 
				</td>
			 </tr>
		 </table>
	</div>
	</form>
	<script type="text/javascript" language="javascript">
	function resetFilters()
	{
		var item;
		if (item = document.getElementById('<%= txtSearch.ClientID %>')){
			item.value = '';
		}
		if (item = document.getElementById('<%= ddlCategories.ClientID %>')) {
			item.value = 0;
		}
	   return true;
	}
   //These Mothods are used to Enable pagging on a TD and Also Empty txtSearch
   function AdjustPagerRow()
   {
		var objTag = null;
		var objCustomRow = null;
		try{
		objCustomRow = getElement("CustomPagerRow");
		objTag = getElementByClassName('FloatingPager');
		objCustomRow.innerHTML = '&nbsp;';
		if (objTag != null && objCustomRow != null)
			{
			objTag.style.display = 'none';
			objCustomRow.innerHTML = "<table cellpadding=0 cellspacing=0 align='left' height='18' ><tr class='cpyFloatingPager'>"+objTag.innerHTML+"</tr></table>";
			}
		}catch(ex){
			alert("Javascript Error:\n"+ex.description);
		}
	}    
	AdjustPagerRow();
	
	var postbackElement;
	Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(beginRequest);
	Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(pageLoaded);

	function beginRequest(sender, args) {
		postbackElement = args.get_postBackElement();
	}    
	function pageLoaded(sender, args) 
	{
		var updatedPanels = args.get_panelsUpdated();
		if (typeof(postbackElement) === "undefined") {
			return;
		} 
		for (i=0; i < updatedPanels.length; i++){
			if (updatedPanels[i].id == '<%= UpdatePanel2.ClientID %>') {
				AdjustPagerRow();
				$get('<%= txtSearch.ClientID %>').value='';               
			}
		}
	}
	//These Mothods are used to Enable pagging on a TD and Also Empty txtSearch


	function OpenNotes(Notes) {
		var strReplaceAll = Notes;
		var intIndexOfMatch = strReplaceAll.indexOf("$*");
		while (intIndexOfMatch != -1) {
			strReplaceAll = strReplaceAll.replace("$*", "<br />")
			intIndexOfMatch = strReplaceAll.indexOf("$*");
		}
		lblNotes.innerHTML = strReplaceAll
		SetPosition()
	}

	function SetPosition() {
		var DivFram = getElement('<%= DivIFrame.ClientID %>')
		document.getElementById('divDisable').style.width = document.body.scrollWidth + 240;
		document.getElementById('divDisable').style.height = document.body.scrollHeight + 8;
		DivFram.style.display = "inline"
		getElement('<%= ddlCategories.ClientID %>').style.display = "none"
	}

	function Reset() {
		lblNotes.innerText = ''
		var DivFram = getElement('<%= DivIFrame.ClientID %>')
		document.getElementById('divDisable').style.width = 0;
		document.getElementById('divDisable').style.height = 0;
		DivFram.style.display = "none";
		getElement('<%= ddlCategories.ClientID %>').style.display = "inline"
		return false;
	}
	function CheckNoisyWord() {
		var mybool = true;
		var InputStr = document.getElementById('<%= txtsearch.ClientID %>').value;
		if (CheckSpecailChar(InputStr) == true) {
			alert("Special characters are not Allowed.\nPlease remove them and try again.");
			document.getElementById('<%= txtSearch.ClientID %>').value = '';
			mybool = false;
			return false;
		}
		if (mybool == false)
			return false;
		else
			return true;
	}
	function StateSaveNewRelease() {
		var URL
		var QueryStringValues = "?txtSearch=" + document.getElementById("<%=txtSearch.ClientID%>").value;
		QueryStringValues += "&ddlCategories=" + document.getElementById('<%=ddlCategories.ClientID %>').value;
		URL = "ReleasesNew.aspx" + QueryStringValues;
		window.location = URL;
	}
	function OnRowClick(ID) {
		var URL
		var QueryStringValues = "?ID=" + ID;
		QueryStringValues += "&reClients=" + '<%=Session("MyNetsolace_ClientID") %>';
		QueryStringValues += "&reCategories=" + document.getElementById('<%=ddlCategories.ClientID %>').value;
		QueryStringValues += "&PrevPage=1"
		URL = "Features.aspx" + QueryStringValues;
		window.location = URL;
	}
	function bubble() {
		event.cancelBubble = true;
	}
</script>
</body>
</html>

