<%@ Page Language="VB" AutoEventWireup="false" ValidateRequest="false" CodeFile="Report_SurveyDiagram.aspx.vb" Inherits="Com_Report_SurveyDiagram" Theme="Default" EnableViewState="false" %> 
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Assembly="RadChart.Net2" Namespace="Telerik.WebControls" TagPrefix="radC" %>
<%@ Register Assembly="RadChart.Net2" Namespace="Telerik.Charting" TagPrefix="radC" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<title>Support Feedback Result</title>
	<link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
	<script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
	<script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
	<script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script> 
	<style type="text/css">
		.tblsummary {font-size:13px;}
		.tblsummary thead tr {height:22px;font-weight:bold;padding-left:3px;line-height:22px;border:0px;}
		.tblsummary thead tr td {background-image:url(../images/bg_hdrSilver.jpg); background-repeat:repeat-x;height:22px;font-weight:bold;padding-left:3px;line-height:22px;border:0px;}
		.tblsummary tbody tr td {border:solid 1px #D3E4F2;height:27px;background-color:White;padding-left:3px;}
		.myclass {width:100%;height:22px;}
		.myclass td{background-image:url(../images/bg_hdrSilver.jpg); background-repeat:repeat-x;height:22px;line-height:20px;font-weight:bold;min-height:22px;max-height:22px;clear:both;font-size:13px;padding:0;padding-left:3px;text-align:left;width:100%;}
		.Graphclass td {border:solid 1px #B8D4E9;text-align:center;}
		.tblOverallclass {}
		.tblOverallclass td {border:solid 1px #B8D4E9;}
	</style>
</head>
<body style ="margin:0px;background-color:#E4F1F7;">
	<form id="form1" runat="server">
	<div>
	<asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="300"  />
		<asp:UpdateProgress ID="Progress1" runat="server">
			<ProgressTemplate>
				<div class="ProgressIndicatorDIV">
					<br />
					<asp:Image ID="Image2" runat="server" ImageUrl="../images/indicator.gif" ImageAlign="AbsMiddle" /> <span style="color:#4B92C1;font-size:14px;"><b>&nbsp;&nbsp;Loading ...</b></span>
					<br /><br />
				</div>
			</ProgressTemplate>
		</asp:UpdateProgress>
	<table width="100%" style="height:100%; margin:0px; padding:0px;background-color:#E4F1F7; " cellspacing="0" cellpadding = "0" border="0">
			 <tr>
				 <td  style="height:20px;background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:5px;width:60%;border-bottom:1 solid #609BD3;">
					 <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Inline">
					   <ContentTemplate>
						Support Feedback Result&nbsp;&nbsp;<asp:Label runat="server" ID="lblActivityCount" />
							&nbsp;<span class="NonBold"></span>
					
					<asp:HiddenField ID="hdnClientID" runat="server" Value="0" />
						</ContentTemplate>
							<Triggers >
								  <asp:AsyncPostBackTrigger ControlID="btnDateSearch" EventName="Click" />
							</Triggers>
					</asp:UpdatePanel>
				</td>
			   <td align="right" style="background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:3px;color:#437494;border-bottom:1 solid #609BD3;width:300px;text-align:right;">
					&nbsp;
				 </td>
			 </tr>
			 <tr>
				<td colspan="2" style="height:40px;background-color:#BADCFC;font-size:11px;">
				  <table border="0" cellpadding="0" cellspacing="0" width="100%" style="white-space:nowrap;">
					 <tr>
						<td style="width:10px;text-align:center;">
							&nbsp;
						</td>
						<td style="width:100px;">
							<span class="GreyTextSmall">From Date</span><br />
							<asp:TextBox runat="server" ID="txtDateFrom" CssClass="GreyTextBox" Width="70px" onfocus="this.blur();" />
							 <img id="img1" align="absMiddle"
								 border="0"
								 onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtDateFrom.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
								 onmouseover="style.cursor='hand';"
								 src="../images/ico_calendar.jpg" alt="" />
						</td>
						 <td style="width:10px;text-align:center;">
							<img alt="" src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
						</td>
						<td style="width:130px;">
							<span class="GreyTextSmall">To Date</span><br />
							<asp:TextBox runat="server" ID="txtDateTo" CssClass="GreyTextBox" Width="70px" onfocus="this.blur();" />
							 <img id="img2" align="absMiddle"
								 border="0"
								 onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtDateTo.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
								 onmouseover="style.cursor='hand';"
								 src="../images/ico_calendar.jpg" alt="" />
							&nbsp;<asp:ImageButton ID="btnDateSearch" runat="server" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" />
						</td>
						 <td style="width:10px;text-align:center;display:none;">
							<img alt="" src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
						</td>
						<td style="width:100px;display:none;">
							<span class="GreyTextSmall">Client</span><br />
							  <asp:DropDownList runat="server" ID="ddlClient"
								Width="150px"
								Enabled="true"
								SkinID="SmallTextCombo"
								DataSourceID="sdsClients" 
								DataTextField="Name"
								DataValueField="ID"
								AutoPostBack="True" >
							  </asp:DropDownList>
							  <asp:SqlDataSource ID="sdsClients" 
								  runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
								  SelectCommand="Clients_GetByUserIDForCom" 
								  SelectCommandType="StoredProcedure"
								  DataSourceMode="DataReader">
								  <SelectParameters>
									  <asp:SessionParameter DefaultValue="" Name="UserID" SessionField="AdminID" Type="Int32" />
								  </SelectParameters>
							  </asp:SqlDataSource>
						</td>
						 <td style="width:10px;text-align:center;display:none;">
							<img alt="" src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
						</td>
						<td style="padding:3px; white-space:nowrap;display:none;" align="left"   >
						  <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" >
							   <span class="GreyTextSmall">Search</span><br />
								<span><asp:TextBox ID="txtSearch" runat="server" onfocus="javascript:this.value='';" MaxLength="50"   Width="170px"  SkinID="GreenSmallTextbox" />
								<asp:ImageButton ID="btnSearch"  runat="server" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" />
								</span>
						   </asp:Panel>
						</td>
						<td> &nbsp;
						</td>
						<td align="right" style="padding-right:10px;">
							<asp:LinkButton ID="lnkResetFilters" runat="server" CssClass="HomeButton">
								<div style="width:110px;" class="LeadDetailButton" onclick="javascript:ViewTickets(); return false;">
								View Tickets
								<img  src="../images/blt_resetFilters.gif" align="absmiddle" width="10" height="10" style="border:0px;"/>
								</div>
							</asp:LinkButton>
						</td>
					</tr>
				 </table>
			   </td>
			</tr>
			<tr>
				<td  id="tdrc_OverAllRating"  colspan="2" style="height:40%;">
				<asp:UpdatePanel ID="UP1" runat="server" UpdateMode="Conditional" RenderMode="Block">
					<ContentTemplate>
						<table class="tblOverallclass" border="0" cellpadding="0" cellspacing="0" style="width:100%;height:100%;">
							<tr>
								<td style="width:60%;height:150;filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#FFFFFF,endColorStr=#ECF7E9);text-align:center;vertical-align:top;margin:0px;padding:0px;">
								<table class="myclass" border="0" cellpadding="0" cellspacing="0"><tr><td>Overall Experience</td></tr></table>
								<div>
									<radc:radchart id="rc_OverAllRating" runat="server" defaulttype="Pie" style="padding:0px;margin:0px;width:100%;"
										seriespalette="" height="150" SeriesOrientation="Horizontal">
									<plotarea seriesorientation="Horizontal">
											<DataTable>
												<Appearance RenderType="PlotAreaRelative" TextVerticalAlign="Middle"  
													TextHorizontalAlign="Center"></Appearance>
											</DataTable>

											<XAxis>
												<appearance color="226, 218, 202" majortick-color="216, 207, 190">
													<majorgridlines color="226, 218, 202" />
													<textappearance textproperties-color="112, 93, 56"></textappearance>
												</appearance>
												<axislabel>
													<textblock text="Y Axis">
														<appearance textproperties-color="112, 93, 56"></appearance>
													</textblock>
												</axislabel>
											</XAxis>

											<YAxis>
												<appearance color="226, 218, 202" majortick-color="226, 218, 202" minortick-color="226, 218, 202">
													<majorgridlines color="231, 225, 212" />
													<minorgridlines color="231, 225, 212" />
													<textappearance textproperties-color="112, 93, 56"></textappearance>
												</appearance>
												<axislabel>
													<textblock>
														<appearance textproperties-color="112, 93, 56"></appearance>
													</textblock>
												</axislabel>
											</YAxis>

											<YAxis2></YAxis2>
											
											
											<appearance border-color="226, 218, 202" seriespalette="Light" 
												dimensions-margins="18%, 23%, 12%, 10%">
												<fillstyle maincolor="254, 255, 228" secondcolor="Transparent"></fillstyle>
											</appearance>
								</plotarea>
								<charttitle visible="False">
											<appearance border-color="">
												<fillstyle maincolor=""></fillstyle>
											</appearance>
											<textblock text="Overall Summary" >
											<appearance textproperties-color="77, 153, 4"></appearance>
											</textblock>
								</charttitle>
								<series>
											<radC:ChartSeries Name="Rating" Type="Pie">
												<appearance border-color="255, 255, 255">
													<fillstyle filltype="ComplexGradient">
														<fillsettings>
															<complexgradient>
																<radC:GradientElement Color="243, 206, 119" />
																<radC:GradientElement Color="236, 190, 82" Position="0.5" />
																<radC:GradientElement Color="210, 157, 44" Position="1" />
															</complexgradient>
														</fillsettings>
													</fillstyle>
													<textappearance textproperties-color="112, 93, 56">
													</textappearance>
												</appearance>
												<Items>
													<radC:ChartSeriesItem Name="Excellent" YValue="100" >
														<label>
															<textblock text="Excellent"></textblock>
														</label>
													</radC:ChartSeriesItem>
													<radC:ChartSeriesItem Name="Good" YValue="56">
														<label>
															<textblock text="Good"></textblock>
														</label>
													</radC:ChartSeriesItem>
													<radC:ChartSeriesItem Name="Fair" YValue="55">
														<label>
															<textblock text="Fair"></textblock>
														</label>
													</radC:ChartSeriesItem>
													<radC:ChartSeriesItem Name="Poor" YValue="56">
														<label>
															<textblock text="Poor"></textblock>
														</label>
													</radC:ChartSeriesItem>
												</Items>
											</radC:ChartSeries>
								</series>
								<appearance border-color="203, 225, 169">
											<fillstyle maincolor="235, 249, 213"></fillstyle>
								</appearance>
								<legend visible="False">
									<appearance border-color="225, 217, 201" 
										corners="Round, Round, Round, Round, 6">
										<itemtextappearance textproperties-color="113, 94, 57"> </itemtextappearance>
									</appearance>
								</legend>
							</radc:radchart>
                                </div>


								</td>
								<td style="width:40%;" valign="top">
									<table class="tblsummary" border="0" cellpadding="0" cellspacing="0" style="width:100%;height:100%;">
										<thead>
											<tr>
												<td style="height:22px;width:50%;">General Stats</td>
												<td></td>
											</tr>
										</thead>
										<tbody>
										<tr>
											<td>Total Tickets Created: </td>
											<td id="tdTotalCreate" runat="server"></td>
										</tr>
										<tr>
											<td>Total Tickets Completed: </td>
											<td id="tdTotalCompleted" runat="server"></td>
										</tr>
										<tr>
											<td>Most Active Person: </td>
											<td id="tdMostActivePerson" runat="server"></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
										</tbody>
									</table>
								</td>
							</tr>
						</table>
					</ContentTemplate>
					<Triggers >
						  <asp:AsyncPostBackTrigger ControlID="btnDateSearch" EventName="Click" />
					</Triggers>
				</asp:UpdatePanel>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="height:60%;">
				<asp:UpdatePanel ID="UP2" runat="server" UpdateMode="Conditional" RenderMode="Block">
					<ContentTemplate>
						<table class="Graphclass" border="0" cellpadding="0" cellspacing="0" style="width:100%;height:100%;font-family:Arial;font-size:12px;font-weight:bold;font-family:Verdana;">
						<tr>
							<td style="width:45px;writing-mode: tb-rl;filter: flipV flipH;padding:3px;text-align:center;position:relative; top:-0px;line-height:45px;background-color:#FFEBCC;">Promptness</td>
							<td style="width:49%;filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=#FFFFFF,endColorStr=#FFF5E6);background-color:White;">
								<radc:radchart id="rc_Promptness" runat="server" defaulttype="Pie" 
										seriespalette="Light" height="104" width="300" SeriesOrientation="Horizontal">
									<plotarea seriesorientation="Horizontal">
											<DataTable>
												<Appearance RenderType="PlotAreaRelative" TextVerticalAlign="Middle"
													TextHorizontalAlign="Center"></Appearance>
											</DataTable>

											<XAxis MinValue="0" maxvalue="4">
												<appearance color="226, 218, 202" majortick-color="216, 207, 190">
													<majorgridlines color="226, 218, 202" />
													<textappearance textproperties-color="112, 93, 56"></textappearance>
												</appearance>
												<axislabel>
													<textblock text="Y Axis">
														<appearance textproperties-color="112, 93, 56"></appearance>
													</textblock>
												</axislabel>
											</XAxis>

											<YAxis MaxValue="4" minvalue="0">
												<appearance color="226, 218, 202" majortick-color="226, 218, 202" minortick-color="226, 218, 202">
													<majorgridlines color="231, 225, 212" />
													<minorgridlines color="231, 225, 212" />
													<textappearance textproperties-color="112, 93, 56"></textappearance>
												</appearance>
												<axislabel>
													<textblock>
														<appearance textproperties-color="112, 93, 56"></appearance>
													</textblock>
												</axislabel>
											</YAxis>

											<YAxis2 MinValue="1" maxvalue="4">
											</YAxis2>
											
											
											<appearance border-color="226, 218, 202" seriespalette="Light" 
												dimensions-margins="18%, 23%, 12%, 10%">
												<fillstyle maincolor="254, 255, 228" secondcolor="Transparent" ></fillstyle>
											</appearance>
								</plotarea>
								<charttitle visible="False">
											<appearance border-color="">
												<fillstyle maincolor=""></fillstyle>
											</appearance>
											<textblock text="Overall Summary" >
											<appearance textproperties-color="77, 153, 4"></appearance>
											</textblock>
								</charttitle>
								<series>
											<radC:ChartSeries Name="Rating" Type="Pie">
												<appearance border-color="255, 255, 255">
													<fillstyle filltype="ComplexGradient">
														<fillsettings>
															<complexgradient>
																<radC:GradientElement Color="243, 206, 119" />
																<radC:GradientElement Color="236, 190, 82" Position="0.5" />
																<radC:GradientElement Color="210, 157, 44" Position="1" />
															</complexgradient>
														</fillsettings>
													</fillstyle>
													<textappearance textproperties-color="112, 93, 56"></textappearance>
												</appearance>
												<Items>
													<radC:ChartSeriesItem Name="Excellent" YValue="100">
														<label>
															<textblock text="Excellent"></textblock>
														</label>
													</radC:ChartSeriesItem>
													<radC:ChartSeriesItem Name="Good" YValue="56">
														<label>
															<textblock text="Good"></textblock>
														</label>
													</radC:ChartSeriesItem>
													<radC:ChartSeriesItem Name="Fair" YValue="55">
														<label>
															<textblock text="Fair"></textblock>
														</label>
													</radC:ChartSeriesItem>
													<radC:ChartSeriesItem Name="Poor" YValue="56">
														<label>
															<textblock text="Poor"></textblock>
														</label>
													</radC:ChartSeriesItem>
												</Items>
											</radC:ChartSeries>
								</series>
								
								<appearance border-color="203, 225, 169" >
											<fillstyle maincolor="235, 249, 213"></fillstyle>
								</appearance>
								<legend visible="False">
									<appearance border-color="225, 217, 201" 
										corners="Round, Round, Round, Round, 6">
										<itemtextappearance textproperties-color="113, 94, 57"> </itemtextappearance>
									</appearance>
								</legend>
							</radc:radchart>
							</td>
							<td style="width:45px;writing-mode: tb-rl;filter: flipV flipH;padding:3px;text-align:center;position:relative; top:-0px;line-height:45px;background-color:#FFFFCC;">Courteousness</td>
							<td style="width:49%;filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=#FFFFFF,endColorStr=#FFFFE6);background-color:White;">
							<radc:radchart id="rc_Courteousness" runat="server" defaulttype="Pie" 
										seriespalette="Light" height="104" width="300" SeriesOrientation="Horizontal">
									<plotarea seriesorientation="Horizontal">
											<DataTable>
												<Appearance RenderType="PlotAreaRelative" TextVerticalAlign="Middle"  
													TextHorizontalAlign="Center"></Appearance>
											</DataTable>

											<XAxis MinValue="1" maxvalue="4">
												<appearance color="226, 218, 202" majortick-color="216, 207, 190">
													<majorgridlines color="226, 218, 202" />
													<textappearance textproperties-color="112, 93, 56"></textappearance>
												</appearance>
												<axislabel>
													<textblock text="Y Axis">
														<appearance textproperties-color="112, 93, 56"></appearance>
													</textblock>
												</axislabel>
											</XAxis>

											<YAxis MaxValue="4" minvalue="1">
												<appearance color="226, 218, 202" majortick-color="226, 218, 202" minortick-color="226, 218, 202">
													<majorgridlines color="231, 225, 212" />
													<minorgridlines color="231, 225, 212" />
													<textappearance textproperties-color="112, 93, 56"></textappearance>
												</appearance>
												<axislabel>
													<textblock>
														<appearance textproperties-color="112, 93, 56"></appearance>
													</textblock>
												</axislabel>
											</YAxis>

											<YAxis2 MinValue="1" maxvalue="4"></YAxis2>
											
											
											<appearance border-color="226, 218, 202" seriespalette="Light" 
												dimensions-margins="18%, 23%, 12%, 10%">
												<fillstyle maincolor="254, 255, 228" secondcolor="Transparent"></fillstyle>
											</appearance>
								</plotarea>
								<charttitle visible="False">
											<appearance border-color="">
												<fillstyle maincolor=""></fillstyle>
											</appearance>
											<textblock text="Overall Summary" >
											<appearance textproperties-color="77, 153, 4"></appearance>
											</textblock>
								</charttitle>
								<series>
											<radC:ChartSeries Name="Rating" Type="Pie">
												<appearance border-color="255, 255, 255">
													<fillstyle filltype="ComplexGradient">
														<fillsettings>
															<complexgradient>
																<radC:GradientElement Color="243, 206, 119" />
																<radC:GradientElement Color="236, 190, 82" Position="0.5" />
																<radC:GradientElement Color="210, 157, 44" Position="1" />
															</complexgradient>
														</fillsettings>
													</fillstyle>
													<textappearance textproperties-color="112, 93, 56">
													</textappearance>
												</appearance>
												<Items>
													<radC:ChartSeriesItem Name="Excellent" YValue="100">
														<label>
															<textblock text="Excellent"></textblock>
														</label>
													</radC:ChartSeriesItem>
													<radC:ChartSeriesItem Name="Good" YValue="56">
														<label>
															<textblock text="Good"></textblock>
														</label>
													</radC:ChartSeriesItem>
													<radC:ChartSeriesItem Name="Fair" YValue="55">
														<label>
															<textblock text="Fair"></textblock>
														</label>
													</radC:ChartSeriesItem>
													<radC:ChartSeriesItem Name="Poor" YValue="56">
														<label>
															<textblock text="Poor"></textblock>
														</label>
													</radC:ChartSeriesItem>
												</Items>
											</radC:ChartSeries>
								</series>
								<appearance border-color="203, 225, 169">
											<fillstyle maincolor="235, 249, 213"></fillstyle>
								</appearance>
								<legend visible="False">
									<appearance border-color="225, 217, 201" 
										corners="Round, Round, Round, Round, 6">
										<itemtextappearance textproperties-color="113, 94, 57"> </itemtextappearance>
									</appearance>
								</legend>
							</radc:radchart>
							</td>
						</tr>
						<tr>
							<td style="width:45px;writing-mode: tb-rl;filter: flipV flipH;padding:3px;text-align:center;position:relative; top:-0px;line-height:45px;background-color:#FFD5D5;">Clarity</td>
							<td style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=#FFFFFF,endColorStr=#FFF5F5);background-color:White;">
								<radc:radchart id="rc_Clarity" runat="server" defaulttype="Pie" 
										seriespalette="Light" height="104" width="300" SeriesOrientation="Horizontal">
									<plotarea seriesorientation="Horizontal">
											<DataTable>
												<Appearance RenderType="PlotAreaRelative" TextVerticalAlign="Middle"  
													TextHorizontalAlign="Center"></Appearance>
											</DataTable>

											<XAxis MinValue="1" maxvalue="4">
												<appearance color="226, 218, 202" majortick-color="216, 207, 190">
													<majorgridlines color="226, 218, 202" />
													<textappearance textproperties-color="112, 93, 56"></textappearance>
												</appearance>
												<axislabel>
													<textblock text="Y Axis">
														<appearance textproperties-color="112, 93, 56"></appearance>
													</textblock>
												</axislabel>
											</XAxis>

											<YAxis MaxValue="4" minvalue="1">
												<appearance color="226, 218, 202" majortick-color="226, 218, 202" minortick-color="226, 218, 202">
													<majorgridlines color="231, 225, 212" />
													<minorgridlines color="231, 225, 212" />
													<textappearance textproperties-color="112, 93, 56"></textappearance>
												</appearance>
												<axislabel>
													<textblock>
														<appearance textproperties-color="112, 93, 56"></appearance>
													</textblock>
												</axislabel>
											</YAxis>

											<YAxis2 MinValue="1" maxvalue="4"></YAxis2>
											
											
											<appearance border-color="226, 218, 202" seriespalette="Light" 
												dimensions-margins="18%, 23%, 12%, 10%">
												<fillstyle maincolor="254, 255, 228" secondcolor="Transparent"></fillstyle>
											</appearance>
								</plotarea>
								<charttitle visible="False">
											<appearance border-color="">
												<fillstyle maincolor=""></fillstyle>
											</appearance>
											<textblock text="Overall Summary" >
											<appearance textproperties-color="77, 153, 4"></appearance>
											</textblock>
								</charttitle>
								<series>
											<radC:ChartSeries Name="Rating" Type="Pie">
												<appearance border-color="255, 255, 255">
													<fillstyle filltype="ComplexGradient">
														<fillsettings>
															<complexgradient>
																<radC:GradientElement Color="243, 206, 119" />
																<radC:GradientElement Color="236, 190, 82" Position="0.5" />
																<radC:GradientElement Color="210, 157, 44" Position="1" />
															</complexgradient>
														</fillsettings>
													</fillstyle>
													<textappearance textproperties-color="112, 93, 56">
													</textappearance>
												</appearance>
												<Items>
													<radC:ChartSeriesItem Name="Excellent" YValue="100">
														<label>
															<textblock text="Excellent"></textblock>
														</label>
													</radC:ChartSeriesItem>
													<radC:ChartSeriesItem Name="Good" YValue="56">
														<label>
															<textblock text="Good"></textblock>
														</label>
													</radC:ChartSeriesItem>
													<radC:ChartSeriesItem Name="Fair" YValue="55">
														<label>
															<textblock text="Fair"></textblock>
														</label>
													</radC:ChartSeriesItem>
													<radC:ChartSeriesItem Name="Poor" YValue="56">
														<label>
															<textblock text="Poor"></textblock>
														</label>
													</radC:ChartSeriesItem>
												</Items>
											</radC:ChartSeries>
								</series>
								<appearance border-color="203, 225, 169">
											<fillstyle maincolor="235, 249, 213"></fillstyle>
								</appearance>
								<legend visible="False">
									<appearance border-color="225, 217, 201" 
										corners="Round, Round, Round, Round, 6">
										<itemtextappearance textproperties-color="113, 94, 57"> </itemtextappearance>
									</appearance>
								</legend>
							</radc:radchart>
							</td>
							<td style="width:45px;writing-mode: tb-rl;filter: flipV flipH;padding:3px;text-align:center;position:relative; top:-0px;line-height:45px;background-color:#E8FAE6;">Knowledgeable</td>
							<td style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=#FFFFFF,endColorStr=#E8FAE6);background-color:White;">
								<radc:radchart id="rc_Knowledgeable" runat="server" defaulttype="Pie" 
										seriespalette="Light" height="104" width="300" SeriesOrientation="Horizontal">
									<plotarea seriesorientation="Horizontal">
											<DataTable>
												<Appearance RenderType="PlotAreaRelative" TextVerticalAlign="Middle"  
													TextHorizontalAlign="Center"></Appearance>
											</DataTable>

											<XAxis MinValue="1" maxvalue="4">
												<appearance color="226, 218, 202" majortick-color="216, 207, 190">
													<majorgridlines color="226, 218, 202" />
													<textappearance textproperties-color="112, 93, 56"></textappearance>
												</appearance>
												<axislabel>
													<textblock text="Y Axis">
														<appearance textproperties-color="112, 93, 56"></appearance>
													</textblock>
												</axislabel>
											</XAxis>

											<YAxis MaxValue="4" minvalue="1">
												<appearance color="226, 218, 202" majortick-color="226, 218, 202" minortick-color="226, 218, 202">
													<majorgridlines color="231, 225, 212" />
													<minorgridlines color="231, 225, 212" />
													<textappearance textproperties-color="112, 93, 56"></textappearance>
												</appearance>
												<axislabel>
													<textblock>
														<appearance textproperties-color="112, 93, 56"></appearance>
													</textblock>
												</axislabel>
											</YAxis>

											<YAxis2 MinValue="1" maxvalue="4"></YAxis2>
											
											
											<appearance border-color="226, 218, 202" seriespalette="Light" 
												dimensions-margins="18%, 23%, 12%, 10%">
												<fillstyle maincolor="254, 255, 228" secondcolor="Transparent"></fillstyle>
											</appearance>
								</plotarea>
								<charttitle visible="False">
											<appearance border-color="">
												<fillstyle maincolor=""></fillstyle>
											</appearance>
											<textblock text="Overall Summary" >
											<appearance textproperties-color="77, 153, 4"></appearance>
											</textblock>
								</charttitle>
								<series>
											<radC:ChartSeries Name="Rating" Type="Pie">
												<appearance border-color="255, 255, 255">
													<fillstyle filltype="ComplexGradient">
														<fillsettings>
															<complexgradient>
																<radC:GradientElement Color="243, 206, 119" />
																<radC:GradientElement Color="236, 190, 82" Position="0.5" />
																<radC:GradientElement Color="210, 157, 44" Position="1" />
															</complexgradient>
														</fillsettings>
													</fillstyle>
													<textappearance textproperties-color="112, 93, 56">
													</textappearance>
												</appearance>
												<Items>
													<radC:ChartSeriesItem Name="Excellent" YValue="100">
														<label>
															<textblock text="Excellent"></textblock>
														</label>
													</radC:ChartSeriesItem>
													<radC:ChartSeriesItem Name="Good" YValue="56">
														<label>
															<textblock text="Good"></textblock>
														</label>
													</radC:ChartSeriesItem>
													<radC:ChartSeriesItem Name="Fair" YValue="55">
														<label>
															<textblock text="Fair"></textblock>
														</label>
													</radC:ChartSeriesItem>
													<radC:ChartSeriesItem Name="Poor" YValue="56">
														<label>
															<textblock text="Poor"></textblock>
														</label>
													</radC:ChartSeriesItem>
												</Items>
											</radC:ChartSeries>
								</series>
								<appearance border-color="203, 225, 169">
											<fillstyle maincolor="235, 249, 213"></fillstyle>
								</appearance>
								<legend visible="False">
									<appearance border-color="225, 217, 201" 
										corners="Round, Round, Round, Round, 6">
										<itemtextappearance textproperties-color="113, 94, 57"> </itemtextappearance>
									</appearance>
								</legend>
							</radc:radchart>
							</td>
						</tr>
					</table>
					</ContentTemplate> 
					<Triggers >
						  <asp:AsyncPostBackTrigger ControlID="btnDateSearch" EventName="Click" />
					</Triggers>
				</asp:UpdatePanel>
					
				</td>
			</tr> 
			<tr style="background-color:#FFFFCB;">
				<td align="left" colspan="2" style="height:30px;font-size:14px;">

				&nbsp;Key: &nbsp;&nbsp;
				<span style="background-color:#7CC24D;width:25;border:outset 1px #FFEBCC;"></span>&nbsp;Excellent&nbsp;&nbsp;
				<span style="background-color:#73C7D7;width:25;border:outset 1px #FFD5D5;"></span>&nbsp;Good&nbsp;&nbsp;
				<span style="background-color:#E1B14A;width:25;border:outset 1px #EFF5FE;"></span>&nbsp;Fair&nbsp;&nbsp;
				<span style="background-color:#C5542E;width:25;border:outset 1px #FFFFCC;"></span>&nbsp;Poor&nbsp;&nbsp;

				</td>
			</tr>
		 </table>
	</div>
	</form>
	<script type="text/javascript" language="javascript">
		function ViewTickets() {
			var txtDateFrom = document.getElementById('<%=txtDateFrom.ClientID%>');
			var txtDateTo = document.getElementById('<%=txtDateTo.ClientID%>');
			window.location = 'Admin_History.aspx?FromDate=' + txtDateFrom.value + '&ToDate=' + txtDateTo.value;

		}
	</script>
</body>
</html>
