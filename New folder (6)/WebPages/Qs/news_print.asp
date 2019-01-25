<% Option Explicit %>
<!-- #include file="../../includes/config.asp" -->
<!-- #include file="../../includes/adovbs.inc" -->
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
<html>
<head>
<title>News</title>
</head>
<table width="670" height="100%" border="0" cellpadding="0" cellspacing="0" align="center">
<tr>
		<td valign="top">
		<table width="94%" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
				<td height="6"><img src="images/spacer.gif" width="10" height="6" /></td>
		</tr>
	 <% If Not (rstNews.eof OR rstNews.bof) Then %>
		<tr class="txt_white">
				<td height="30" class="horLine_ltIndigo"><strong><%= rstNews("Headline") %></strong></td>
		</tr>
		<tr>
				<td class="txt_white" height="6"><img src="images/spacer.gif" width="10" height="6" /></td>
		</tr>
		<tr>
				<td class="txt_white"><%= Replace(rstNews("News"),vbcrlf,"<br>") %></td>
		</tr>
		 <% Else %>
		<tr>
			<td><img src="images/spacer.gif" width="10" height="6" /></td>
		</tr> 
		<% End If %>
		</table></div></td>
</tr>
</table>
</html>
<%
	rstNews.Close
	conFruDb.Close

	Set rstNews = Nothing
	Set conFruDb = Nothing
%>