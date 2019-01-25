<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ClientContactUser.aspx.vb" Inherits="MyNetsolace_ClientContactUser" Theme="Default"%>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
	<title>Untitled Page</title>
	<link href="../../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript"  src="../../scripts/functions.js" language="javascript" ></script>
	<script type="text/javascript" language="javascript">
	function FixPager(){  
		var objTag = null;
			var objCustomRow = null;
			try{
			trPager.style.display='inline';
			objCustomRow = getElement("tdPager");
			objTag = getElementByClassName("gvwSilverPager");
			objCustomRow.innerHTML ='&nbsp;';
			if (objTag != null && objCustomRow != null)
			{        
				var objPagerHTML = getElement('tblPager').outerHTML;
				objCustomRow.innerHTML = objPagerHTML;
				objCustomRow.className = "cpygvwSilverPager";
				objTag.style.display = 'none';
			}
			else
			{
				//if the pager has not been displayed hide the row.
				trPager.style.display='none';
			}
			}catch(ex){
				//alert("Javascript Error:\n"+ex.description);
			}
	}
</script>
</head>
<body style="margin:0; padding:0; height:100%; width:100%">
	<form id="form1" runat="server">
	<div><asp:HiddenField ID="hdnClientID" runat="server" />
	<asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="300"  />
	 <asp:UpdateProgress ID="Progress1" runat="server">
			<ProgressTemplate>
			   <div class="ProgressIndicatorDivGray" style="right: 20px; bottom: 40px">
					<br />
					<img src="../../images/indicator.gif" align="absmiddle" /><b>&nbsp;&nbsp;Loading ...</b>
					<br /><br />
				</div>
			</ProgressTemplate>
	</asp:UpdateProgress>
	<table style="height:100%;width:100% " cellspacing="0" border="0" cellpadding="0"  >
			 <tr class="GalleryTitle" style="background-image:url('../../images/bg_mainHdr_1.jpg');height:31px;">
				 <td  style="height:31px;background-color:#A0CDEE;font-size:12px;padding:5px;width:50%;">
					<asp:UpdatePanel ID="upRecordCount" runat="server" UpdateMode="Always">
					<ContentTemplate>
					   <span style="font-weight:bold;">Manage Users&nbsp;|&nbsp;<asp:Label ID="lblRecordCount" runat="server" Text="0"></asp:Label></span>&nbsp;(<asp:Literal ID="ltrlFiltered" runat="server" Text="All"></asp:Literal>)
					 </ContentTemplate>
					</asp:UpdatePanel>
				</td>
				 <td style="background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:3px;color:#437494;text-align:right;">
					&nbsp;&nbsp;&nbsp;&nbsp;
					<img src="../../images/btn_ResetFilters.jpg" style="cursor:pointer;" onclick="javascript:resetFilters();"/>
					 <img  align="absmiddle" src="../../images/pixel_skyBlue.jpg" width="1" height="20" />
					
				 </td>
			 </tr>
			 <tr>
				<td colspan="2" style="height:40px;font-size:11px;border-top:0px;">
				  <table border="0" cellpadding="0" cellspacing="0" width="100%" class="gvwSearchSilver" style="position:relative;top:-2px;">
					<tr>
					<td style="width:100px;" align="center" id="tdnewbtn">
						<div id="divNewKey" style="padding:4 2 4 2; width:90px;">
							<input id="btnNewUser" type="button" onclick="javascript:window.location='ClientContactNewUser.aspx'" class="btnSilver" value="NEW USER" style="width:80px;"/></div>
					</td>
					<td><div class="straightline"></div></td>
					<td style="padding-left:5px; padding-right:5px; width: 110px; ">
						<span style="font-size: 7pt; color: #7c8798">Filter</span><br />
						<asp:DropDownList
							ID="ddlInActive"
							runat="server"
							SkinID="SmallTextCombo"
							AutoPostBack="True" Width="100px">
							<asp:ListItem Selected="True" Value="0">Show All</asp:ListItem>
							<asp:ListItem Value="1">Active</asp:ListItem>
							<asp:ListItem Value="2">InActive</asp:ListItem>
						</asp:DropDownList>
					</td>
					<td><div class="straightline"></div></td>
					<td style="white-space:nowrap;padding-left:5px;">
					<asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch">
						<span class="GreyTextSmall">Search</span><br />
							<span><asp:TextBox ID="txtSearch" runat="server" MaxLength="50" onkeyup="if(CheckNoisyWord()==false) return false;" onfocus="javascript:this.value='';"  Width="100px" />
							<asp:ImageButton ID="btnSearch" runat="server" OnClientClick="if(CheckNoisyWord()==false) return false; trPager.style.display='none';" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" />
							</span>
					</asp:Panel>
					</td>
					<td style="width:25%;">
					&nbsp;&nbsp;
					</td>
				   </tr>
				 </table>
			   </td>
			 </tr>
			 <tr>
			   <td  colspan="2" style="height:100%;">
			   <div id="divScroll" style="height:100%; width:100%; overflow-y:auto;" class="GrayScrollBar">
					<asp:UpdatePanel ID="UpdatePanel2"
						 runat="server" 
						 UpdateMode="Always"
						 RenderMode="Inline">
						 <ContentTemplate>
						<asp:GridView 
						ID="gvUsers" 
						runat="server" 
						AutoGenerateColumns="False" 
						EnableTheming="false" 
						SkinID="gvwSilver" 
						CellPadding="0"
						CellSpacing="0"
						DataKeyNames="ID" 
						DataSourceID="ODS_GetAll"
						BorderWidth="0"
						Width="100%"
						AllowPaging="true" 
						PageSize="50"
						
						BackColor="white" 
						CssClass="gvwSilver" 
					    Height="100%" ShowFooter="true"
						AllowSorting="true" EnableViewState="true"
						AlternatingRowStyle-CssClass="altRow" >
						<FooterStyle CssClass="gvwSilverFooter" />
						<PagerStyle CssClass="gvwSilverPager" />
						<HeaderStyle CssClass="gvwSilverHeader" />
						<PagerSettings Mode="NextPreviousFirstLast" Position="Bottom" />
						
							<Columns>

								<asp:TemplateField  HeaderText="Name" SortExpression="Name"  HeaderStyle-Width="45%">
									<ItemTemplate>
										<span title='<%#Server.HtmlEncode(Eval("Name"))%>'><b><%#Functions.StringTruncate(Server.HtmlEncode(Eval("Name")), 25)%></b></span>
									</ItemTemplate>
									<FooterTemplate>&nbsp;</FooterTemplate>
								</asp:TemplateField>

								<asp:TemplateField HeaderText="User Name" SortExpression="UserName"  HeaderStyle-Width="20%">
									<ItemTemplate>
										<span title='<%#Functions.StringTruncate(Server.HtmlEncode(Eval("UserName")), 25)%>'> <%#Functions.StringTruncate(Server.HtmlEncode(Eval("UserName")), 25)%></span>
									</ItemTemplate>
									<FooterTemplate>&nbsp;</FooterTemplate>
								</asp:TemplateField>

								<asp:TemplateField HeaderText="Phone" SortExpression="Phone"  HeaderStyle-Width="15%">
									<ItemTemplate>
										<%#Functions.StringTruncate(Server.HtmlEncode(Eval("WorkPhone")), 20)%>
									</ItemTemplate>
									<FooterTemplate>&nbsp;</FooterTemplate>
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Email" SortExpression="Email" HeaderStyle-Width="20%">
									<ItemTemplate>
										<span title='<%#Functions.StringTruncate(Server.HtmlEncode(Eval("Email1")), 25)%>'><b><%#Functions.StringTruncate(Server.HtmlEncode(Eval("Email1")), 25)%></b></span>
									</ItemTemplate>
									<FooterTemplate>&nbsp;</FooterTemplate>
								</asp:TemplateField>
								</Columns>
							<EmptyDataTemplate>
								<table class="NoRecord" runat="server" id="EmptyDataRow">
										<tr>
											<td>
												<img align="absmiddle" runat="server" src="../../images/ico_alert.gif" />&nbsp;&nbsp;No User Found !
											</td>
										</tr>
								</table> 
							  </EmptyDataTemplate>
							  <EmptyDataRowStyle />
							<PagerSettings Mode="NextPreviousFirstLast" Visible="true" Position="Bottom" />
								<PagerTemplate>
									<table id="tblPager" width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
										   <td style="border:0; width:85%;">Showing Users <asp:Literal ID="ltrlStartCount" runat="server" Text="0"></asp:Literal> to <asp:Literal ID="ltrlEndCount" runat="server" Text="0"></asp:Literal> of <asp:Literal ID="ltrlTotalCount" runat="server" Text="0"></asp:Literal></td> 
										   <td style="border:0;" align="right">Page&nbsp;<asp:Literal ID="ltrlStartPage" runat="server" Text="0"></asp:Literal> of <asp:Literal ID="ltrlLastPage" runat="server" Text="0"></asp:Literal>&nbsp;&nbsp;&nbsp;<asp:LinkButton ID="lnkBtnFirst" runat="server" CommandName="page" CommandArgument="first"><asp:Image ID="imgFirst" runat="server" ImageUrl="../../../admin/RnD/images/First_blk.jpg" ToolTip="First" /></asp:LinkButton>&nbsp;<asp:LinkButton ID="lnkBtnPrevious" runat="server" CommandName="page" CommandArgument="prev"><asp:Image ID="imgPrevious" runat="server" ImageUrl="../../../../admin/RnD/images/back_blk.jpg" ToolTip="Previous" /></asp:LinkButton> &nbsp;<asp:LinkButton ID="lnkBtnNext" runat="server" CommandName="page" CommandArgument="next"><asp:Image ID="imgNext" runat="server" ImageUrl="../../../../admin/RnD/images/Next_blk.jpg"  ToolTip="Next" /></asp:LinkButton>&nbsp;<asp:LinkButton ID="lnkBtnLast" runat="server" CommandName="page" CommandArgument="last"><asp:Image ID="imgLast" runat="server" ImageUrl="../../../../admin/RnD/images/Last_blk.jpg" ToolTip="Last" /></asp:LinkButton>&nbsp;&nbsp;&nbsp;</td>
										</tr>
									</table>
							 </PagerTemplate>
						</asp:GridView>
					   </ContentTemplate>
								  <Triggers >
								  <asp:AsyncPostBackTrigger ControlID="ddlInActive" EventName="SelectedIndexChanged" />
								  <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" /> 
								   </Triggers>
							</asp:UpdatePanel> 
						<asp:ObjectDataSource 
						ID="ODS_GetAll" 
						runat="server" EnableViewState="true"
						SortParameterName="sortExpression"
						SelectMethod="ClientsContactsGetAll"  
						TypeName="Portal.BLL.Client.Client_Contacts"
						SelectCountMethod="ClientsContactsGetAllCount" 
						MaximumRowsParameterName="maximumRows"
							StartRowIndexParameterName="startRowIndex"   EnablePaging="True"
						 OldValuesParameterFormatString="" >
							<SelectParameters>
								<asp:ControlParameter ControlID="hdnClientID" DefaultValue="1" Name="ClientID" PropertyName="Value" Type="Int32" />
								<asp:ControlParameter ControlID="ddlInActive" DefaultValue="0" Name="InActive" PropertyName="SelectedValue" Type="Int32" />
								<asp:Parameter Name="sortExpression" DefaultValue="" Type="String" />
								<asp:ControlParameter ControlID="txtSearch" DefaultValue="" Name="txtsearch" PropertyName="Text"
									Type="String" />
							</SelectParameters>
						</asp:ObjectDataSource>
					</div>
			   </td>
			 </tr>
			 <tr id="trPager" class="pager" style="display:none;">
				<td id="tdPager" style="height:20px; border-top:solid 1px #B7CFE2;" colspan="2" >&nbsp;</td>
			 </tr> 
			</table>
	</div>

<script type="text/javascript" language="javascript">

	function resetFilters() {
		var item;
		if (item = document.getElementById('<%= txtSearch.ClientID %>')) {
			item.value = '';
			trPager.style.display = 'none';
		}

		if (item = document.getElementById('<%= ddlInActive.ClientID %>')) {
			item.value = '0';
			trPager.style.display = 'none';
		}
		document.getElementById('<%= btnSearch.ClientID  %>').click();
		return true;
	}
	function ChangeFooterCss() {
		var rowsCount = parseInt(gvUsers.rows.length);
		var element = getElementByClassName('gvwSilverFooter');
		if (element != null && (rowsCount % 2) != 0) {
			element.className = 'gvwSilverFooterOdd';
		}
	}

	function ShowUserDetail(userId) {
		var str = 'ClientContactNewUser.aspx?UserID=' + userId;
		str += '&ddlInActive=' + document.getElementById('<%=ddlInActive.ClientID%>').value;
		str += '&txtSearch=' + document.getElementById('<%=txtSearch.ClientID%>').value;
		window.location = str
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
	function ChangeRowsClass() {
		var element = getElementByClassName('gvwSilverFooter');
		if (element != null) {
			element.className = 'gvwSilverFooterOdd';
		}
	}

	function SetRowStyle() {
		var element = getElementByClassName('gvwSilverFooterOdd');
		if (element != null) {
			element.className = 'gvwSilverFooter';
		}
	}

	AdjustPagerRow();

	function AdjustPagerRow() {
		var objTag = null;
		var objCustomRow = null;
		try {
			trPager.style.display = 'inline';
			objCustomRow = getElement("tdPager");
			objTag = getElementByClassName("gvwSilverPager");
			objCustomRow.innerHTML = '&nbsp;';
			if (objTag != null && objCustomRow != null) {
				var objPagerHTML = getElement('tblPager').outerHTML;
				objCustomRow.innerHTML = objPagerHTML;
				objCustomRow.className = "cpygvwSilverPager";
				objTag.style.display = 'none';
			}
			else {
				//if the pager has not been displayed hide the row.
				trPager.style.display = 'none';
			}
		} catch (ex) {
			//alert("Javascript Error:\n"+ex.description);
		}
	}
	
</script>
	</form>
</body>
</html>