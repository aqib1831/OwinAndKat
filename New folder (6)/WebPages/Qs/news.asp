<% Option Explicit %>
<!-- #include file="../../includes/config.asp" -->
<!-- #include file="../../admin/includes/adovbs.inc" -->
<% 
'*******************************************************************************************************
'*		Page Description:  Fruitation Main Page
'*		Input Parameter:   
'*		Developer Name:    Tahir Manzoor
'*		Date:			   09/02/2006
'*		Change History														                           
'*			Developer:       														                           
'*			Date:            															                           
'*			Change:          															                           
'*****************************************************************************
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = #1/1/2000#
'******************************* Variables ***********************************
	Dim conFruDb
	Dim rstNews
	Dim reqNewsID
	Dim strSQLNews
	
'******************************* Request Variables ***************************
	reqNewsID = Trim(Request.QueryString("ID"))
'******************************* Intialization *******************************	
	
'******************************* Queries *************************************
	strSQLNews = "Select * From News WHERE ID = " & reqNewsID
	
'''******************************* Query Execution **************************
	Set conFruDb = Server.CreateObject("ADODB.Connection")
	conFruDb.Open cstFransupportConnectionString

	Set rstNews = Server.CreateObject("ADODB.Recordset")
	rstNews.Open strSQLNews,conFruDb, adOpenForwardOnly, adLockReadOnly, adCmdText
%>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
		<td valign="top">
		<div style="width:100%;height:95%;overflow:hidden;" id="NewsContents">
		<table width="94%" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
				<td height="6"><img src="images/spacer.gif" width="10" height="6" /></td>
		</tr>
	 <% If Not (rstNews.eof OR rstNews.bof) Then %>
		<tr class="txt_white">
				<td height="30" class="horLine_ltIndigo"><strong><%= rstNews("Headline") %></strong></td>
		</tr>
		<tr>
				<td class="txt_white" height="6"><img src="images/spacer.gif" width="10" height="6" /><font color="#FFFFFF"</td>
		</tr>
		<tr>
				<td class="txt_white"><span class="txt_whiteContents"><%= Replace(Replace(Replace(Replace(rstNews("News"),vbcrlf,"<br>"), "<p ","<p class='txt_whiteContents' "), "<font ","<font color=#FFFFFF "), "<p>", "<p class='txt_whiteContents'>") %></span></td>
		</tr>
		 <% Else %>
		<tr>
			<td><img src="images/spacer.gif" width="10" height="6" /></td>
		</tr> 
		<% End If %>
		</table></div></td>
</tr>
<tr>
		<td height="70" class="bg_ltPurple">
		<table width="98%" border="0" align="center" cellpadding="0" cellspacing="2">
		<tr>
				<td align="right"><input type="image" src="images/btn_back.jpg" width="68" height="48" onClick="goBack();" /></td>
				<td><input id="imgUp" type="image" src="images/btn_scrollUpD.jpg" width="68" height="48" onClick="scrollUp();" /></td>
				<td><input id="imgDown" type="image" src="images/btn_scrollDownD.jpg" width="68" height="48" onClick="scrollDown();" /></td>
				<td align="left"><input type="image" src="images/btn_printNews.jpg" width="109" height="48" onClick="onPrint();"/></td>
		</tr>
		</table></td>
</tr>
</table>
<%
	rstNews.Close
	conFruDb.Close

	Set rstNews = Nothing
	Set conFruDb = Nothing
%>