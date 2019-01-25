<% Option Explicit %>
<!-- #include file="../../includes/config.asp" -->
<!-- #include file="../../includes/adovbs.inc" -->
<% 
'*******************************************************************************************************
'*		Page Description:  Qs Main Page
'*		Input Parameter:   
'*		Developer Name:    Tahir Manzoor
'*		Date:			   09/02/2006
'*		Change History														                           
'*			Developer:       														                           
'*			Date:            															                           
'*			Change:          															                           
'*****************************************************************************
 
'******************************* Variables ***********************************
	Dim conDB
	Dim rstProducts
	Dim rstNews
	Dim rstTip
	Dim strSQLProduct
	Dim strSQLNews
	Dim strSQLTip
	Dim cmdSql
	Dim rstWeeklyImage
	Dim rstTreats

	
'******************************* Request Variables ***************************

'******************************* Intialization *******************************	
	
'******************************* Queries *************************************
	strSQLProduct = "Select top 2 * From QS_Products Where Deleted = 0 Order By ID Desc"
	strSQLNews = "Select top 5 * From News Where Deleted = 0 Order By ID Desc"
	strSQLTip = "Select top 4 * From QS_Tips Where Deleted = 0 Order By ID Desc"
	
'''******************************* Query Execution **************************
	Set conDb = Server.CreateObject("ADODB.Connection")
	conDb.Open cstFransupportConnectionString
			
	Set rstProducts = Server.CreateObject("ADODB.Recordset")
	rstProducts.Open strSQLProduct,conDb, adOpenForwardOnly, adLockReadOnly, adCmdText

	Set rstNews = Server.CreateObject("ADODB.Recordset")
	rstNews.Open strSQLNews,conDb, adOpenForwardOnly, adLockReadOnly, adCmdText

	Set rstTip = Server.CreateObject("ADODB.Recordset")
	rstTip.Open strSQLTip,conDb, adOpenForwardOnly, adLockReadOnly, adCmdText
	
	Set cmdSql = Server.CreateObject("ADODB.Command")
	cmdSql.ActiveConnection = conDb
	cmdSql.CommandType = adCmdStoredProc
	cmdSql.CommandText = "QS_Get_WeeklySpecialImage"
	Set rstWeeklyImage = cmdSql.Execute()

	cmdSql.CommandText = "QS_Get_IrresistibleTreats"
	Set rstTreats = cmdSql.Execute()
	Set cmdSql = Nothing


%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
<title>QS</title>
<style type=text/css>
<!--
.style1 {
	color: #FF9900;
	font-family: Verdana;
	font-size: 20px;
	font-weight: bold;
}
.style6 {
	font-family: Verdana;
	font-size: 16px;
	font-weight: bold;
}
.style5 {
	font-family: Verdana;
	font-size: 14px;
	font-weight: bold;
	color: #0597E4
}
.style12 {
	font-family: Verdana;
	font-size: 12px;
}
.style17 {
	font-size: x-small;
	font-family: Verdana;
}
.style22{
	font-size:12px;
	font-family:Verdana;
	font-weight:bold;
}

-->
</style>
<script language="javascript">
function ShowDiv(NewsID)
{
		try
		{
			document.getElementById('PrintFrame').src = 'news_print.asp?ID='+NewsID;
			document.getElementById('content_backup').innerHTML = document.getElementById('content').innerHTML;
			document.getElementById('content').innerHTML = document.getElementById('divLoading').innerHTML;
			var objXmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			objXmlHttp.Open("GET", "news.asp?ID="+NewsID, false);
			objXmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			objXmlHttp.Send();
			document.getElementById('content').innerHTML = objXmlHttp.responseText;
			EnableScroll();
		}
		catch(ex) 
		{
			alert(ex.description);
		}
}

function goBack()
{
		try
		{
			document.getElementById('content').innerHTML = document.getElementById('content_backup').innerHTML ;
		}
		catch(ex) 
		{
			alert(ex.description);
		}
}

function scrollUp(){
	try{
		if (document.getElementById('NewsContents').clientHeight < document.getElementById('NewsContents').scrollHeight)
				document.getElementById('NewsContents').scrollTop-=20;
	}catch(ex){
	}
}

function scrollDown(){
	try{
		if (document.getElementById('NewsContents').clientHeight < document.getElementById('NewsContents').scrollHeight)
				document.getElementById('NewsContents').scrollTop+=20;
	}catch(ex){
	}
}


function EnableScroll()
{
	if (document.getElementById('NewsContents').clientHeight < document.getElementById('NewsContents').scrollHeight)
			{
			document.getElementById('imgUp').src = "images/btn_scrollUp.jpg";
			document.getElementById('imgDown').src = "images/btn_scrollDown.jpg";
			}
	else
		 {
 			document.getElementById('imgUp').src = "images/btn_scrollUpD.jpg";
			document.getElementById('imgDown').src = "images/btn_scrollDownD.jpg";
		 }		
}

function onPrint()
{
try{
	frames["PrintFrame"].focus();
	frames["PrintFrame"].print();
	}catch(ex){}
}

	function init()
	{
		getElement('div_onlineLinks').style.left = getRealLeft(getElement('OpenLiksID'))-140;
		getElement('div_onlineLinks').style.top = getRealTop(getElement('OpenLiksID'))-200;
	}

</script>
<link href="style/style.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="../../scripts/functions.js"></script>
</head>

<body onLoad="init();">
<table width="675" border="0" cellspacing="0" cellpadding="0" style="height:713px">
  <tr>
    <td width="335" align="left" valign="top" class="bg_shkgPink"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <% If Not (rstWeeklyImage.BOF OR rstWeeklyImage.EOF) Then %>
	  <tr>
        <td><img src="<%= cstFransupportResourcesFolder %>Qs/<%= rstWeeklyImage("Image") %>" alt="QS Weekly Specials" /></td>
      </tr>
	  <% End If %>
      <tr>
        <td><table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td colspan="2" class="hdng_white">Irresistible Treats </td>
          </tr>
		  <% If NOT (rstTreats.BOF OR rstTreats.EOF) Then
		  	  While NOT rstTreats.EOF %>
          <tr>
            <td colspan="2"><img src="images/spacer.gif" alt="spacer" width="10" height="16" /></td>
          </tr>
          <tr>
            <td width="82"><img src="<%= cstFransupportResourcesFolder %>Qs/<%= rstTreats("Image") %>" width="76" height="75" /></td>
            <td width="238" class="txt_white"><span class="subHdng_white"><%= rstTreats("Title") %></span><br />
              <%= rstTreats("Description") %></td>
          </tr>
		  <% rstTreats.MoveNext
		  	  Wend
		  End If %>
          <tr>
            <td colspan="2"><iframe name="PrintFrame" id="PrintFrame" frameborder="0" width="0" height="0" src="blank_frame.asp"></iframe><img src="images/spacer.gif" alt="spacer" width="10" height="5" /></td>
          </tr>
        </table></td>
      </tr>
      
    </table></td>
    <td width="3" background="images/verLine_ltIndigo.jpg"><img src="images/verLine_ltIndigo.jpg" alt="Spacer" width="3" height="3" /></td>
    <td align="left" valign="top" class="bg_purple" height="713">
    <div id="content" style="width:100%;height:705px;">
    <table width="100%" height="705" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="116"><img src="images/bodyTop_saladC.jpg" alt="Salad Creations" width="337" height="116" /></td>
      </tr>
      <tr>
        <td height="46"><img src="images/hdng_latestFromCorporate.jpg" alt="Latest from corporate" width="335" height="46" /></td>
      </tr>
      <tr>
        <td valign="top">
        	<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
          <%
			While NOT rstProducts.EOF and 1=1
		%>
		  <tr>
            <td colspan="2"><img src="images/spacer.gif" width="10" height="5"></td>
          </tr>
          <tr>
            <td width="23"><img src="images/blt_round.jpg" alt="New" width="16" height="11" /></td>
            <td width="269" class="txt_whiteSml"><span class="txtBld_white"><%= rstProducts("Name") %></span><BR>
                <%
				  If Len(rstProducts("Description")) > 100 Then
				  	Response.Write(Left(rstProducts("Description"), 97)&"...")
				  Else
				  	Response.Write(rstProducts("Description"))
				  End If
				%></td>
          </tr>
          <tr>
            <td colspan="2"><img src="images/spacer.gif" width="10" height="5"></td>
          </tr>
          <%
		   	   rstProducts.MoveNext
		   Wend
	   %>
          
        </table>
        </td>
      </tr>
      <tr>
        <td height="27">
        <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td width="636" height="27" colspan="2" class="hdng_ltIndigo">News</td>
          </tr>
        </table></td>
      </tr>
      <% If NOT rstNews.EOF and 1 = 1 Then %>
      <tr>
        <td class="bg_ltIndigo" valign="top">
        <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
		<% While NOT rstNews.EOF %>
          <tr>
            <td height="32" class="horLine_ltIndigo"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr onClick="ShowDiv(<%= rstNews("ID") %>);" style="cursor:pointer">
                <td width="23"><img src="images/blt_arrow.jpg" width="16" height="16" /></td>
                <td width="295" class="txt_white">
				<%  
					If Len(rstNews("Headline")) > 48 Then
						Response.Write(Left(rstNews("Headline"), 45)&"...")
					Else
						Response.Write(rstNews("Headline"))
					End If
				%>
                &nbsp;</td>
              </tr>
            </table></td>
          </tr>
		<%
				rstNews.MoveNext
			Wend
		%>  
      </table></td>
      </tr>
      <% End If %>
      <tr>
        <td valign="top" height="115">
        <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr height="10">
            <td><img src="images/spacer.gif" height="10" width="1"></td>
          </tr>
          <tr height="25">
            <td class="hdng_ltIndigo">Did you know?</td>
          </tr>
		  <% While NOT rstTip.EOF and 1= 1 %>
          <tr>
            <td height="20"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="23"><img src="images/blt_round.jpg"  width="16" height="11" /></td>
                <td width="295" class="txt_white">
				<%
					If Len(rstTip("Tip")) > 100 Then
						Response.Write(Left(rstTip("Tip"), 97)&"...")
					Else
						Response.Write(rstTip("Tip"))
					End If 
				%>
                </td>
              </tr>
              <tr>
                <td colspan="2"><img src="images/spacer.gif" width="10" height="5"></td>
              </tr>
            </table></td>
          </tr>
          <%
		  		rstTip.MoveNext 
		  	Wend 
		  %>
        </table></td>
      </tr>
      <tr><td height="5"><img src="images/spacer.gif" width="5" height="5"></td></tr>
	  <tr class="bg_ltIndigo">
        <td height="30" valign="middle"><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="35" align="center" class="hLinkWhite"><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td width="173"><img src="images/btn_viewUserG.jpg" width="173" height="34" style="cursor:pointer" onClick="document.getElementById('divGuide').style.display='inline';" /></td>
                <td><img src="images/btn_onlineLinks.jpg" width="164" height="34" style="cursor:pointer" onClick="document.getElementById('div_onlineLinks').style.display='inline';" id="OpenLiksID" /></td>
              </tr>
            </table></td>
          </tr>
          <tr><td height="10"><img src="images/spacer.gif" width="1" height="10"></td></tr>
        </table></td>
      </tr>
    </table>
    </div>
    </td>
  </tr>
</table>
<div id="divGuide" class="div_border" style=" position:absolute; top:0px; left:0px; width:675px; height:715px; background:#D0DECF; overflow:hidden; display:none">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
    <tr>
      <td height="57"><img src="images/header_userGuide.jpg" width="623" height="57" border="0" usemap="#Map" /></td>
    </tr>
    <tr>
      <td align="left" valign="top" height="10"><img src="images/spacer.gif" width="5" height="10" /></td>
    </tr>
    <tr>
      <td align="center" valign="top">
        <table border="0" align="center" cellpadding="0" cellspacing="0" class="div_bgWhite" height="100%">
          <tr>
            <td>
              <div style="width:99%;height:100%;overflow:auto">
               <table width="100%">
				<tr>
				  <td>&nbsp;</td>
				</tr>
				<tr>
					<td align="center"><img src="images/Netsolace_logo.jpg" alt="Netsolace INC" width="290" height="60" /></td>
				  </tr>
				  <tr>
					<td class="style1"><a name="top" id="top">Qs User Guide</a></td>
				  </tr>
				</table>
			   <table width="100%" border="0" align="center" cellpadding="1" cellspacing="0">
  
  <tr bgcolor="#E8E8E8">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="35" bgcolor="#FFFFFF" class="style6">Index</td>
  </tr>
  <tr bgcolor="#E8E8E8">
    <td width="11%" bgcolor="#E9E9E9" class="style12">&nbsp;</td>
    <td width="89%" height="25" bgcolor="#E9E9E9" class="style22"><a href="#1main">1. Qs main Home Page</a> </td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td bgcolor="#FFFFFF" class="style12"></td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><a href="#1.1"><blockquote><li>Qs Weekly Specials</blockquote></a></td>
  </tr>
  <tr bgcolor="#E8E8E8">
    <td bgcolor="#FFFFFF" class="style12"></td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><a href="#1.2"><blockquote><li>Qs news </li></blockquote></a></td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td bgcolor="#FFFFFF" class="style12"></td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><a href="#1.1"><blockquote><li>Qs Navigation Bar</blockquote></a></td>
  </tr>
  <tr bgcolor="#E9E9E9">
    <td class="style12">&nbsp;</td>
    <td height="25" class="style12"><a href="#2.0" class="style22">2. Employee Time Management </a></td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><blockquote><a href="#2.1"><li>Clock-In and Clock Out </li></a></blockquote></td>
  </tr>
  <tr bgcolor="#E8E8E8">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><blockquote><a href="#2.1.2"><li>Clock-In </li></a></blockquote></td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><blockquote><a href="#2.1.3"><li>Clcok-out</li></a></blockquote>    </td>
  </tr>
  <tr bgcolor="#E9E9E9">
    <td class="style12">&nbsp;</td>
    <td height="25" class="style12"><a href="#3.0" class="style22">3. Taking Qs Orders </a></td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><blockquote><a href="#3.1"><li>Taking an order </li></a></blockquote>    </td>
  </tr>
  <tr bgcolor="#E8E8E8">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="25" bgcolor="#FFFFFF" class="style12"> <blockquote><a href="#3.1.1"><li>Edit quantities of same product</li> </a></blockquote>    </td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><blockquote><a href="#3.1.2"><li>To add new product under same category and same size </li></a></blockquote>    </td>
  </tr>
  <tr bgcolor="#E8E8E8">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><blockquote><a href="#3.1.3"><li>To add new product under same category and different size </li></a></blockquote>    </td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><blockquote><a href="#3.1.4">
      <li>To remove selected product from order section </li>
    </a></blockquote>    </td>
  </tr>
  <tr bgcolor="#E8E8E8">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><blockquote><a href="#3.1.5"> <li>To process a complimentary order</li> </a>    </blockquote></td>
  </tr>
  <tr bgcolor="#E9E9E9">
    <td class="style12">&nbsp;</td>
    <td height="25" class="style12"><a href="#4.0" class="style22">4 Processing Qs Orders </a></td>
  </tr>
  <tr bgcolor="#E8E8E8">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><blockquote><a href="#4.1"><li>To edit order from payment screen </li></a></blockquote>    </td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><blockquote><a href="#4.2"><li>Process payments</li></a></blockquote>    </td>
  </tr>
  <tr bgcolor="#E8E8E8">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><blockquote><a href="#4.2.1"><li>Cash </li></a></blockquote>    </td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><blockquote><a href="#4.2.2"><li>Credit Card </li></a></blockquote>    </td>
  </tr>
  <tr bgcolor="#E8E8E8">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><blockquote><a href="#4.2.3" class="style19"><li> Check</li></a></blockquote></td>
  </tr>
  <tr bgcolor="#E8E8E8">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><blockquote><a href="#4.2.4" class="style19"><li> Gift cards </li></a></blockquote></td>
  </tr>
  <tr bgcolor="#E9E9E9">
    <td class="style12">&nbsp;</td>
    <td height="25" class="style12"><a href="#5.0" class="style22">5 Manager's Menu Access </a></td>
  </tr>
  <tr bgcolor="#E8E8E8">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><blockquote><a href="#5.1" class="style19"><li>Managers Menu ~ Administration </li></a></blockquote></td>
  </tr>
  <tr bgcolor="#E8E8E8">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><blockquote><a href="#5.1.1" class="style19"><li>Order History </li></a></blockquote></td>
  </tr>
  <tr bgcolor="#E8E8E8">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><blockquote><a href="#5.1.2" class="style19"><li>Refund Order </li></a></blockquote></td>
  </tr>
  <tr bgcolor="#E8E8E8">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><blockquote><a href="#5.1.3" class="style19"><li>Balance Register</li> </a></blockquote></td>
  </tr>
  <tr bgcolor="#E8E8E8">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><blockquote><a href="#5.1.3" class="style19"><li>Dayends </li></a></blockquote></td>
  </tr>
  <tr bgcolor="#E8E8E8">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><blockquote><a href="#5.1.4" class="style19"><li>Employee Center</li> </a></blockquote></td>
  </tr>
  <tr bgcolor="#E8E8E8">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><blockquote><a href="#5.1.4.1" class="style19"><li>Managers Menu </li></a></blockquote></td>
  </tr>
  <tr bgcolor="#E8E8E8">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><blockquote><a href="#5.1.4.2" class="style19"><li>Available Reports </li></a></blockquote></td>
  </tr>
  <tr bgcolor="#E8E8E8">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><blockquote><a href="#5.1.5" class="style19"><li>Alerts </li></a></blockquote></td>
  </tr>
  <tr bgcolor="#E8E8E8">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><blockquote><a href="#5.2" class="style19"><li>Managers Menu - Utility Functions </li></a></blockquote></td>
  </tr>
  <tr bgcolor="#E8E8E8">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><blockquote><a href="#5.2.1" class="style19"><li>Store Information</li> </a></blockquote></td>
  </tr>
  <tr bgcolor="#E8E8E8">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><blockquote><a href="#5.2.2" class="style19"><li>Terminal settings </li></a></blockquote></td>
  </tr>
  <tr bgcolor="#E8E8E8">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><blockquote><a href="#5.2.3" class="style19"><li>Coupons </li></a></blockquote></td>
  </tr>
  <tr bgcolor="#E8E8E8">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><blockquote><a href="#5.2.4" class="style19"><li>Backup/Restore</li></a></blockquote></td>
  </tr>
  <tr bgcolor="#E8E8E8">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><blockquote><a href="#5.2.5" class="style19"><li>Manual CC Auth </li></a></blockquote></td>
  </tr>
  <tr bgcolor="#E8E8E8">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><blockquote><a href="#5.2.6" class="style19"><li>Synchronize Online</li> </a></blockquote></td>
  </tr>
  <tr bgcolor="#E8E8E8">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><blockquote><a href="#5.2.7" class="style19"><li>Menu Settings</li> </a></blockquote></td>
  </tr>
  <tr bgcolor="#E8E8E8">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><blockquote><a href="#5.3" class="style19"><li>Managers Menu ~ Inventory</li> </a></blockquote></td>
  </tr>
  <tr bgcolor="#E8E8E8">
    <td bgcolor="#FFFFFF" class="style12">&nbsp;</td>
    <td height="25" bgcolor="#FFFFFF" class="style12"><blockquote><a href="#5.4" class="style19"><li>Managers Menu ~ Prices and Taxes </li></a></blockquote></td>
  </tr>
</table>
			   <table width="100%" border="0">
  
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  
  <tr>
    <td class="style1"><a name="1main">1 Qs Main Home Page </a> <a href="#top" class="style17">[Top]</a></td>
  </tr>
  <tr class="style12">
    <td>Quickserve (Qs) home page is divided into three sections:</td>
  </tr>
  <tr>
    <td class="style6">&nbsp;</td>
  </tr>
  <tr>
    <td class="style6"><a name="1.1"> 1.1 Qs Weekly Specials</a> </td>
  </tr>
  <tr class="style12">
    <td>All Qs weekly specials are listed on the left side of the screen.</td>
  </tr>
  <tr>
    <td class="style6">&nbsp;</td>
  </tr>
  <tr>
    <td class="style6"><a name="1.2">1.2 Qs News</a></td>
  </tr>
  <tr class="style12">
    <td>All Qs related  news is posted in the middle section of the home page screen, which is updated  by corporate office.</td>
  </tr>
  <tr>
    <td class="style6">&nbsp;</td>
  </tr>
  <tr>
    <td class="style6"><a name="1.3">1.3 Qs Navigation Bar</a></td>
  </tr>
  <tr class="style12">
    <td>The Quickserve  (Qs) software navigation bar is located on the right side of the home page and  acts as an access point for all necessary functions.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="style1"><a name="2.0">2 Employee Time Management </a><a href="#top" class="style17">[Top]</a></td>
  </tr>
  <tr>
    <td class="style6">&nbsp;</td>
  </tr>
  <tr>
    <td class="style6"><a name="2.1">2.1 Clock-In and Clock-Out</a></td>
  </tr>
  <tr class="style12">
    <td>Qs Functions are  only available to employees who are clocked-in to the Qs software.</td>
  </tr>
  <tr>
    <td class="style5">&nbsp;</td>
  </tr>
  <tr>
    <td class="style5"><a name="2.1.2">2.1.2 Clock-In</a></td>
  </tr>
  <tr class="style12">
    <td>Tap the Clock In button to bring up the  clock-in screen.&nbsp; Swipe the Employee card  or enter the Employee Pin to clock-in to Qs.</td>
  </tr>
  <tr>
    <td class="style5">&nbsp;</td>
  </tr>
  <tr>
    <td class="style5"><a name="2.1.3">2.1.3 Clock-Out</a></td>
  </tr>
  <tr class="style12">
    <td>Tap the Clock Out button to bring up the  clock-out screen.&nbsp; Swipe the Employee  card or enter the Employee Pin to clock-out of Qs.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="style1"> <a name="3.0">3 Taking Qs Orders </a><a href="#top" class="style17">[Top]</a></td>
  </tr>
  <tr class="style12">
    <td>Click or Tap on the New Orders button to place new orders within the system.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="style6"><a name="3.1">3.1 Taking an Order</a></td>
  </tr>
  <tr class="style12">
    <td>Note: When  pressing the buttons on the touch-screen, make sure the selected button turns Blue.&nbsp; The program will record the selection only when the button turns  blue.</td>
  </tr>
  <tr class="style12">
    <td>Click or Tap the New Order button and swipe your  employee card on the login screen or manually enter your pin to access order  screen:</td>
  </tr>
  <tr class="style12">
    <td>1. Select  merchandise in the Category (1) section.</td>
  </tr>
  <tr class="style12">
    <td>2. Select  size from the Size/Price (2) section.</td>
  </tr>
  <tr class="style12">
    <td>3. Select  product from the Product (3) section. </td>
  </tr>
  <tr class="style12">
    <td>4. Select Options (4) if available for  selected product.</td>
  </tr>
  <tr class="style12">
    <td>5. The selected saleable merchandise will show up in the Receipt (5) section.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="style5"><a name="3.1.1">3.1.1 To edit quantities of same product</a></td>
  </tr>
  <tr class="style12">
    <td>If the customer  places an order for the same product in multiple quantities follow the  procedure below:</td>
  </tr>
  <tr class="style12">
    <td>Repeat selections from step 1 through 4.</td>
  </tr>
  <tr class="style12">
    <td>Verify Receipt section reflects the selection.</td>
  </tr>
  <tr class="style12">
    <td>Or</td>
  </tr>
  <tr class="style12">
    <td>Select Product within Receipt section and click Quantity button to activate pad to edit  product quantity.&nbsp; Select number to reflect  total quantity of same product.</td>
  </tr>
  
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="style5"><a name="3.1.2">3.1.2 To add new product under same category and same size </a></td>
  </tr>
  <tr class="style12">
    <td>If customer  places an order for a different product under the same category and same size,  follow the procedure below:</td>
  </tr>
  <tr class="style12">
    <td> Repeat selections from step 1 through 4. </td>
  </tr>
  <tr class="style12">
    <td>
      Verify Receipt section reflects the order correctly.    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="style5"><a name="3.1.3">3.1.3 To add new product under same category and different size </a><a href="#top" class="style17">[Top]</a></td>
  </tr>
  <tr class="style12">
    <td>If customer  places an order for a different product under the same category and different  size, follow the procedure below:</td>
  </tr>
  <tr class="style12">
    <td>Repeat selections from step 1 through 4.</td>
  </tr>
  <tr class="style12">
    <td>Verify Receipt section reflects the order correctly.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="style5"><a name="3.1.4">3.1.4 To remove selected products from order section</a></td>
  </tr>
  <tr class="style12">
    <td>If the customer  changes their mind and would like to have a product removed from the order,  follow the procedure below:</td>
  </tr>
  <tr class="style12">
    <td>Note: On a large  order, the desired product to remove may be found by using the Up and Down keys situated at the bottom of receipt section.</td>
  </tr>
  <tr class="style12">
    <td> Select product to be removed from Receipt section by utilizing the Up and Down keys. </td>
  </tr>
  <tr class="style12">
    <td> Click Remove button to remove selected product from the order. </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="style5"><a name="3.1.5">3.1.5 To process a Complimentary order</a></td>
  </tr>
  <tr class="style12">
    <td>Complimentary (Comp) order can be entered in two ways:</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="style5"><a name="3.1.5.1">3.1.5.1 Before selecting any category</a></td>
  </tr>
  <tr class="style12">
    <td>Press the comp button before selecting any category.</td>
  </tr>
  <tr class="style12">
    <td>Repeat selections from step 1 through 4.</td>
  </tr>
  <tr class="style12">
    <td>Verify that the order will show up with the (Comp) caption.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="style5"><a name="3.1.5.5">3.1.5.5 After category has been selected</a></td>
  </tr>
  <tr class="style12">
    <td>Assuming that  product(s) have already been selected for the current order and are showing on  the Receipt section of the screen:</td>
  </tr>
  <tr class="style12">
    <td>Tap or click on the desired item that will be  marked as Complimentary on the  Receipt section.</td>
  </tr>
  <tr class="style12">
    <td>Click on the Comp button at the bottom of the Receipt section.</td>
  </tr>
  <tr class="style12">
    <td>The item will be marked as Complimentary (Comp) within the Receipt section and that item&rsquo;s  price will be deducted from the total.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="style1"><a name="4.0">4 Processing Qs Orders </a><a href="#top" class="style17">[Top]</a></td>
  </tr>
  <tr class="style12">
    <td>After the customer  has finished placing the order, select the Payment button to process payment.&nbsp; After  successfully processing an order, click Exit to return to taking new orders.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="style6"><a name="4.1">4.1 To edit order from Payment screen</a></td>
  </tr>
  <tr class="style12">
    <td>Any necessary  changes to the order should be made before selecting the payment screen.&nbsp; Click Cancel on payment screen to go back and edit the order.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="style6"><a name="4.2">4.2 Process Payments</a></td>
  </tr>
  <tr class="style12">
    <td>Payments can be  processed in three ways:</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="style5"><a name="4.2.1">4.2.1 Cash</a></td>
  </tr>
  <tr class="style12">
    <td><em>Exact Amount:</em> If customer provides with the exact amount, select Exact Amount button and the transaction will process automatically.</td>
  </tr>
  <tr class="style12">
    <td><em>Quick Amount  Buttons: </em>Below the exact amount button, there are buttons  that allow you to enter the most likely amounts the customer might give.&nbsp; The Amount  Tendered and Change Due amounts  will be displayed.&nbsp; Click OK to process payment.</td>
  </tr>
  <tr class="style12">
    <td><em>Pad: </em>If  the above methods cannot be used for what the customer provides, click the  &ldquo;Pad&rdquo; button to open a number pad.&nbsp; Enter  the amount tendered and click OK.&nbsp; The Amount Tendered and Change Due amounts will be  displayed.&nbsp; Click OK to process payment.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="style5"><a name="4.2.2">4.2.2 Credit Card</a></td>
  </tr>
  <tr class="style12">
    <td><em><u>IMPORTANT:</u> Each franchisee has to check their credit card  company portal EVERY NIGHT to ensure  all credit card transactions have been settled.</em></td>
  </tr>
  <tr class="style12">
    <td>They need to also VERIFY on a regular basis with their bank that the correct funds  were deposited in their bank account. </td>
  </tr>
  <tr class="style12">
    <td><em><u>It is the franchisee&rsquo;s responsibility to reconcile their accounts.</u>&nbsp; Errors related to third-party service providers such as merchant processing are completely unrelated to the Netsolace Qs software.  Neither Netsolace nor its software may be held responsible for these external errors.&nbsp; </em></td>
  </tr>
  <tr class="style12">
    <td>All the steps above will  ensure that all major problems can be quickly identified and acted upon.</td>
  </tr>
  <tr class="style12">
    <td>Swipe Credit Card:</td>
  </tr>
  <tr class="style12">
    <td> Swipe the credit card to automatically enter all  credit card information into the process screen.&nbsp; Click Process to process payment.&nbsp; </td>
  </tr>
  <tr class="style12">
    <td>Card approval notification will display onscreen  and a receipt will print for signatures and one for customer to keep. </td>
  </tr>
  <tr class="style12">
    <td>Manually Enter Credit Card:</td>
  </tr>
  <tr class="style12">
    <td>If the credit card information is entered manually, the system may require customer address information under AVS option to verify data.</td>
  </tr>
  <tr class="style12">
    <td>Card approval notification will display onscreen and a receipt will print for signatures and one for the customer to keep.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="style5"><a name="4.2.2.1">4.2.2.1 Credit Card Declines </a><a href="#top" class="style17">[Top]</a></td>
  </tr>
  <tr class="style12">
    <td>In case of credit card decline, a screen with following options will appear on a new Transaction Decline screen:</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="style5"><a name="4.2.2.2">4.2.2.2 Try Another Credit Card</a></td>
  </tr>
  <tr class="style12">
    <td>Selecting this option will bring back to payment screen to allow entering and processing payment with a different credit card.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="style5"><a name="4.2.2.3">4.2.2.3 Enter voice authorization</a></td>
  </tr>
  <tr class="style12">
    <td>If there is no internet connectivity, the credit card will not be authorized. Call the credit card company to obtain a voice authorization number.</td>
  </tr>
  <tr class="style12">
    <td>Click on Enter voice authorization to manually enter that number to process the order.</td>
  </tr>
  <tr class="style12">
    <td>Click OK to process payment.</td>
  </tr>
  <tr>
    <td class="style5">&nbsp;</td>
  </tr>
  <tr>
    <td class="style5"><a name="4.2.2.4">4.2.2.4 Void/Cancel Ticket</a></td>
  </tr>
  <tr class="style12">
    <td>This option will allow voiding or canceling ticket in progress.</td>
  </tr>
  <tr>
    <td class="style5">&nbsp;</td>
  </tr>
  <tr>
    <td class="style5"><a name="4.2.2.5">4.2.2.5 Change Payment Mode</a></td>
  </tr>
  <tr class="style12">
    <td>Click this option to change payment mode to other available payment options.</td>
  </tr>
  <tr>
    <td class="style5">&nbsp;</td>
  </tr>
  <tr>
    <td class="style5"><a name="4.2.3">4.2.3 Check</a></td>
  </tr>
  <tr class="style12">
    <td>Note: Customer should provide a check with the exact amount along with valid I.D. for processing.</td>
  </tr>
  <tr class="style12">
    <td>Enter Check number and Bank name.</td>
  </tr>
  <tr class="style12">
    <td>Click Process to process payment by check.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="style5"><a name="4.2.4">4.2.4 Gift Cards</a></td>
  </tr>
  <tr class="style12">
    <td>Gift Cards can be used as a form of payment if the store is utilizing Nova as their credit card processing merchant.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="style1"><a name="5.0">5 Manager&rsquo;s Menu Access </a><a href="#top" class="style17">[Top]</a></td>
  </tr>
  <tr class="style12">
    <td>To access manager&rsquo;s menu, tap the Manager&rsquo;s Menu button on the Home page and swipe manager&rsquo;s card. Only Supervisors and Managers have access to this section of software.</td>
  </tr>
  <tr>
    <td class="style6"><a name="5.1">5.1 Manager&rsquo;s Menu ~ Administration: </a></td>
  </tr>
  
  <tr>
    <td class="style12">All administrative functions for the software are listed within this section.</td>
  </tr>
  <tr>
    <td class="style5">&nbsp;</td>
  </tr>
  <tr>
    <td class="style5"><a name="5.1.1">5.1.1 Order History</a></td>
  </tr>
  <tr class="style12">
    <td>Tap  on this icon to bring up the Last 10  orders that were processed.</td>
  </tr>
  <tr class="style12">
    <td> Tap on View to  see transaction details and click Print to  re-print receipt. </td>
  </tr>
  <tr class="style12">
    <td>Number Pad on the same screen provides the ability to search  orders by order number. </td>
  </tr>
  <tr>
    <td class="style5">&nbsp;</td>
  </tr>
  <tr>
    <td class="style5"><a name="5.1.2"> 5.1.2 Refund Order:</a></td>
  </tr>
  <tr class="style12">
    <td>Refunds can only be applied for full amount of order.</td>
  </tr>
  <tr class="style12">
    <td>Last 10 orders can also be accessed from the Refund Order screen by selecting available link on top right of screen.</td>
  </tr>
  <tr class="style12">
    <td>Enter Order No. to refund on Refund Order screen and hit enter.</td>
  </tr>
  <tr class="style12">
    <td>Pertaining order details will come up on the right side of screen.</td>
  </tr>
  <tr class="style12">
    <td>Enter Refund Reason in the provided field.</td>
  </tr>
  <tr class="style12">
    <td>Select Add items back to inventory if applicable.</td>
  </tr>
  <tr class="style12">
    <td>Tap Refund Order to apply a refund for selected order.</td>
  </tr>
  <tr>
    <td class="style5">&nbsp;</td>
  </tr>
  <tr>
    <td class="style5"><a name="5.1.3">5.1.3 Balance Register:</a></td>
  </tr>
  <tr class="style12">
    <td><em><u>IMPORTANT:</u> Each franchisee has to check their credit card  company portal EVERY NIGHT to ensure  all credit card transactions have been settled.</em></td>
  </tr>
  <tr class="style12">
    <td>They need to also VERIFY on a regular basis with their bank that the correct funds  were deposited in their bank account.</td>
  </tr>
  <tr class="style12">
    <td><u>It is the franchisee&rsquo;s responsibility to reconcile their accounts.</u>&nbsp; Errors related to third-party service providers such as merchant processing are completely unrelated to the Netsolace Qs software. Neither Netsolace nor its software may be held responsible for these external errors.&nbsp; </td>
  </tr>
  <tr class="style12">
    <td> All  the steps above will ensure that all major problems can be quickly identified  and acted upon.</td>
  </tr>
  <tr class="style12">
    <td>This option accesses the Balance register screen where it provides the ability to reconcile Cash, Checks, Gift Card transactions and Credit Card transactions. Register balance should be performed on all terminals and is required to occur before performing Dayend.</td>
  </tr>
  <tr class="style12">
    <td>Note: Balance Register function should be performed on both terminals, Terminal_1 and Terminal_2, consecutively. It is imperative that Dayend should always be performed after performing the Balance Register function.</td>
  </tr>
  <tr class="style12">
    <td>Hand Over option to switch cashiers/employees is also provided in this section. Hand over can be performed multiples times during the day, if needed.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="style5"><a name="5.1.3.1">5.1.3.1 Reconcile Cash: </a><a href="#top" class="style17">[Top]</a></td>
  </tr>
  <tr class="style12">
    <td>Select Open Drawer to open drawer.</td>
  </tr>
  <tr class="style12">
    <td>Count Coins and Bills and enter them in their respective denominations.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="style5"><a name="5.1.3.2">5.1.3.2 Reconcile Credit Card Sales:</a></td>
  </tr>
  <tr class="style12">
    <td>Mark Credit Card and Gift Card sales on screen against actual receipts and online batch.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  
  <tr>
    <td class="style5"><a name="5.1.3.3">5.1.3.3 Reconcile Checks:</a></td>
  </tr>
  <tr class="style12">
    <td>Mark Check amounts on screen against checks on hand.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="style5"><a name="5.1.4">5.1.4 Dayend: </a></td>
  </tr>
  <tr class="style12">
    <td>Dayend has to be performed everyday to reconcile total sales for entire day. Dayend can only be performed once per day.</td>
  </tr>
  <tr class="style12">
    <td>Note: Dayend process should be performed on the Master terminal, usually Terminal_1 if the store has two terminals.</td>
  </tr>
  <tr class="style12">
    <td>Dayend is performed in the following four steps:</td>
  </tr>
  <tr class="style12">
    <td>Reconcile All Terminals: To perform Dayend, all terminals should be reconciled first by performing the Balance Register function.</td>
  </tr>
  <tr class="style12">
    <td>Stores with 2 terminals, Terminal_1 and Terminal_2, should perform Balance Register function on both terminals consecutively.</td>
  </tr>
  <tr class="style12">
    <td>Stores with just one terminal can perform Dayend after reconciling that terminal.</td>
  </tr>
  <tr class="style12">
    <td>Close Online CC Batch: The Dayend process closes the credit card batch automatically.</td>
  </tr>
  <tr class="style12">
    <td>Report Online Sales: This function sends the Daily Sales report to Socket Fransupport.</td>
  </tr>
  <tr class="style12">
    <td>Backup: After each Dayend, the DB is backed up and saved on the master terminal. The backup is incremental where the same file is replaced at Dayend with the changes.</td>
  </tr>
  <tr class="style12">
    <td>Closeout Transaction Summary report is displayed after the Dayend process, which can be printed or exported to PDF or in an Excel format. This report is also accessible from Report Center under Deposits as Deposit Summary.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="style5"><a name="5.1.5">5.1.5 Employee Center:</a></td>
  </tr>
  <tr class="style12">
    <td>Employee center provides the ability to:</td>
  </tr>
  <tr class="style12">
    <td>Manage all employees.</td>
  </tr>
  <tr class="style12">
    <td>Administer Employee cards and PINs.</td>
  </tr>
  <tr class="style12">
    <td>Manage employees&rsquo; Time records.</td>
  </tr>
  <tr class="style12">
    <td>Track Employee History</td>
  </tr>
  <tr class="style12">
    <td>Inactivate Employees</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="style5"><a name="5.1.6">5.1.6 Report Center: </a><a href="#top" class="style17">[Top]</a></td>
  </tr>
  <tr>
    <td class="style5"><a name="5.1.6.1">5.1.6.1 Manage Access:</a></td>
  </tr>
  <tr class="style12">
    <td>This feature allows the manager to select reports that will be available to Supervisors to view.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="style5"><a name="5.1.6.2">5.1.6.2 Available Reports:</a></td>
  </tr>
  <tr class="style12">
    <td>Report Center provides the ability to run reports based on predefined criteria.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr class="style5">
    <td><u>Orders:</u></td>
  </tr>
  <tr class="style12">
    <td>Reports available under orders tab are:</td>
  </tr>
  <tr class="style12">
    <td>Orders List: All orders for specific date range are listed on this report.</td>
  </tr>
  <tr class="style12">
    <td>Refunded Orders: All refunded orders for a defined date range are listed on this report.</td>
  </tr>
  <tr class="style12">
    <td>Discounted Orders: All discounted orders for a defined date range are listed on this report.</td>
  </tr>
  <tr class="style12">
    <td>Comp Items: This report lists complimentary orders for a defined date range.</td>
  </tr>
  <tr class="style12">
    <td>Promotions Report: This report provides data for a defined date against the predefined promotion packages.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr class="style5">
    <td><u>Inventory:</u></td>
  </tr>
  <tr class="style12">
    <td>Reports available under inventory tab are:</td>
  </tr>
  <tr class="style12">
    <td>Inventory Usage: This report lists inventory usage for defined date range.</td>
  </tr>
  <tr class="style12">
    <td>Inventory On Hand: This report lists the entire inventory on hand for tracking.</td>
  </tr>
  <tr class="style12">
    <td>Sales: Reports available under sales tab are:</td>
  </tr>
  <tr class="style12">
    <td>Sales Summary by Payment Type: This report lists sales summary based on payment type.</td>
  </tr>
  <tr class="style12">
    <td>Sales by Category: This report lists sales based on the category of the products sold.</td>
  </tr>
  <tr class="style12">
    <td>Sales by Category Detailed Report: This report lists sales for detailed categories for the products sold.</td>
  </tr>
  <tr class="style12">
    <td>Sales by Hour: This report provides a real-time graphic view of sales by the hour.</td>
  </tr>
  <tr class="style12">
    <td>Sales Amount by Hour: This report provides a real-time graphic view of sales amount by hour.</td>
  </tr>
  <tr class="style12">
    <td>Store Sales Tax Summary: This report provides store sales tax summary.</td>
  </tr>
  <tr class="style12">
    <td>Sales Tax Details: This report provides stores sales tax details.</td>
  </tr>
  <tr class="style12">
    <td>Weekly Sales Report: This report provides weekly sales amount.</td>
  </tr>
  <tr class="style12">
    <td>Store Sales Tax Summary: This report shows the total tax collected during a given period of time.</td>
  </tr>
  <tr class="style12">
    <td>Sales Tax Details: This report provides a detailed report on taxes collected during a defined date range.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr class="style5">
    <td><u>Employees:</u></td>
  </tr>
  <tr class="style12">
    <td> Reports available under employees tab are:</td>
  </tr>
  <tr class="style12">
    <td>Timing History: This report provides clock in and clock out history for all employees.</td>
  </tr>
  <tr class="style12">
    <td>Employee Productivity: This report provides a list of orders taken, sales amounts and percentage of orders taken.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr class="style5">
    <td><u>Deposits:</u></td>
  </tr>
  <tr class="style12">
    <td>Reports available under deposits tab are:</td>
  </tr>
  <tr class="style12">
    <td>Closeout Summary: This report lists the closeout deposit summary for a specific day.</td>
  </tr>
  <tr class="style12">
    <td>Drawer Activity Report: This report lists all the drawer activities including all sales and hand over information.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="style5"><a name="5.1.7">5.1.7 Alerts: </a><a href="#top" class="style17">[Top]</a></td>
  </tr>
  <tr class="style12">
    <td>Alerts section provides immediate alerts on the following Qs functions:</td>
  </tr>
  <tr class="style12">
    <td>Inventory (New Items Purchased): This shows alerts for any new items purchased and their quantity.</td>
  </tr>
  <tr class="style12">
    <td>Refunded (Orders): This shows alerts for most recent orders that were refunded.</td>
  </tr>
  <tr class="style12">
    <td>Inventory (Out of Stock Items): This shows alerts for items that are currently out of stock.</td>
  </tr>
  <tr class="style12">
    <td>Employees (Late comers): This shows alerts for employees who have arrived late to work. This alert shows an employee as a late arrival if they sign-in after 9AM.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="style6"><a name="5.2">5.2 Manager&rsquo;s Menu - Utility Functions: </a><a href="#top" class="style17">[Top]</a></td>
  </tr>
  <tr>
    <td class="style5">&nbsp;</td>
  </tr>
  <tr>
    <td class="style5"><a name="5.2.1">5.2.1 Store Information: </a></td>
  </tr>
  <tr class="style12">
    <td>Provides access to area where basic store operations data and other related settings can be defined:</td>
  </tr>
  <tr class="style12">
    <td>General Information: Store #, Username and Password are entered on this screen for synchronization. All store related information automatically populates in the applicable fields on the right side of this screen.</td>
  </tr>
  <tr class="style12">
    <td>Sales Tax: All applicable taxes and royalty percentage are defined on this screen. Also, enter your applicable Tax Rate in the applicable tax field. Verify that correct Royalty amount and percentage are showing in the applicable field.</td>
  </tr>
  <tr class="style12">
    <td>Merchant Setup: Merchant number and password are entered for payment processing merchant on this screen.</td>
  </tr>
  <tr class="style12">
    <td>Other Settings:</td>
  </tr>
  <tr class="style12">
    <td>Allows the ability to set report printer</td>
  </tr>
  <tr class="style12">
    <td>Allows the ability to edit message at bottom of all receipts</td>
  </tr>
  <tr class="style12">
    <td>Allows the ability to turn on or off Price Synchronization function. Selecting this option as No would retain local prices and will not sync with prices for products with other stores</td>
  </tr>
  <tr class="style12">
    <td>Allows the ability to turn on or off AVS option for credit card processing</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr class="style5">
    <td><a name="5.2.2">5.2.2 Terminal Settings:</a> </td>
  </tr>
  <tr class="style12">
    <td>Allows the ability to change the terminal&rsquo;s default settings:</td>
  </tr>
  <tr class="style12">
    <td>Define Terminal Name under Terminal Identification</td>
  </tr>
  <tr class="style12">
    <td>Select Receipt Printer under Receipt Printer</td>
  </tr>
  <tr class="style12">
    <td>Enable Auto Receipt printing</td>
  </tr>
  <tr class="style12">
    <td>Change Beginning of Drawer Count amount</td>
  </tr>
  <tr class="style12">
    <td>Define maximum discount limit amount</td>
  </tr>
  <tr class="style12">
    <td>Enable auto logout from order entry screen due to inactivity</td>
  </tr>
  <tr class="style12">
    <td>Define inactivity time to logout from order entry screen</td>
  </tr>
  <tr class="style12">
    <td>Pole Display default and thank you messages are entered within this function</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr class="style5">
    <td><a name="5.2.3">5.2.3 Coupons:</a> <a href="#top" class="style17">[Top]</a></td>
  </tr>
  <tr class="style12">
    <td>Coupons can be defined and managed from this section for discounts.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr class="style5">
    <td><a name="5.2.4">5.2.4 Backup/Restore:</a> </td>
  </tr>
  <tr class="style12">
    <td>Provides the ability to backup and restore the database to the desired location.</td>
  </tr>
  <tr class="style12">
    <td>Backup can be performed at any time by clicking the Backup Now button</td>
  </tr>
  <tr class="style12">
    <td>Restore can be performed from a desired restore point</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr class="style5">
    <td><a name="5.2.5">5.2.5 Manual CC Auth:</a></td>
  </tr>
  <tr class="style12">
    <td> This feature provides the capability to process manual sale or refunds.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr class="style5">
    <td><a name="5.2.6">5.2.6 Synchronize Online: </a> </td>
  </tr>
  <tr class="style12">
    <td>This option synchronizes Qs data such as categories, sizes, products, options and prices online with Salad Creations corporate database.</td>
  </tr>
  <tr class="style12">
    <td>Price synchronization is optional and can be set from the Store Information section of the Manager&rsquo;s menu</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr class="style5">
    <td><a name="5.2.7">5.2.7 Menu Settings: </a></td>
  </tr>
  <tr class="style12">
    <td>Allows the ability to enter custom merchandise that is being sold locally and not company wide.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr class="style6">
    <td><a name="5.3">5.3 Manager&rsquo;s Menu ~ Inventory: </a><a href="#top" class="style17">[Top]</a></td>
  </tr>
  <tr class="style12">
    <td> There are two types of Inventory managed at the store:</td>
  </tr>
  <tr class="style12">
    <td>Consumables: Consumables are non-perishable items. Consumables contain complimentary products such as straws, napkins etc.</td>
  </tr>
  <tr class="style12">
    <td>Merchandise: Merchandise includes all saleable inventories.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr class="style5">
    <td>Inventory Items:</td>
  </tr>
  <tr class="style12">
    <td>Lists all inventory on hand for managing and tracking purposes based upon merchandise and consumable types.</td>
  </tr>
  <tr class="style12">
    <td>Allows the ability to add, edit or delete Inventory item as Merchandise and Consumables in relation to their respective vendors.</td>
  </tr>
  <tr class="style12">
    <td>Allows the ability to specify Re-Order Point for all merchandise and consumable inventory items.</td>
  </tr>
  <tr class="style12">
    <td>Receive Inventory: Allows the ability to scan in the received inventory.</td>
  </tr>
  <tr class="style12">
    <td>Vendors: Allows the ability to manage vendors</td>
  </tr>
  <tr class="style12">
    <td>Lists all the current vendors for the store.</td>
  </tr>
  <tr class="style12">
    <td>Allows the ability to add, edit or delete vendors.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr class="style5">
    <td>Consumables:</td>
  </tr>
  <tr class="style12">
    <td>Provides the ability to assign all consumables to their respective categories.</td>
  </tr>
  <tr class="style12">
    <td>Lists all the available consumables.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr class="style6">
    <td><a name="5.4">5.4 Manager&rsquo;s Menu ~ Prices &amp; Taxes:</a></td>
  </tr>
  <tr class="style12">
    <td>Pricing: All merchandise information is automatically synchronized online with corporate database.</td>
  </tr>
  <tr class="style12">
    <td>Prices can be edited individually to reflect store&rsquo;s set prices.</td>
  </tr>
  <tr class="style12">
    <td>Promotions: This screen is used to create and manage packages. Packages are a group of multiple products that can be discounted.</td>
  </tr>
  <tr class="style12">
    <td>Taxes: No Tax is enabled on all merchandise, by default. Tax Name should be checked off to apply tax for each taxable product.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
    <td class="style1">Important Notes Regarding Payment Application Best Practices (PABP) <a href="#top" class="style17">[Top]</a></td>
</tr>
<tr class="style12">
<td>According to the Visa U.S.A Cardholder Information Security Plan (CISP), Store manager must follow given below instructions </td></tr>
<tr>
<td>&nbsp;</td></tr>
<tr class="style12">
<td>
<ul>
<li>The Manager / Supervisor should be responsible for maintaining an Updated Anti-Virus Software &amp; a Firewall on the server as well as the terminal machines. </li></ul></td></tr>
<tr class="style12">
<td>
<ul>
<li>The Manager / Supervisor / Operator should be aware of the PABP Implementation Guide on the security measures on processing the client information. </li></ul></td></tr>
<tr class="style12">
<td>
<ul>
<li>The Manager should not give Admin privileges to Supervisor / Operator, so that they might not install un-wanted software which may be un secure for confidential information. </li></ul></td></tr>
<tr class="style12">
<td>
<ul>
<li>The Manager should remove any unnecessary services such as File-sharing, Unencrypted FTP, Telnet etc from all systems before handing them over to the Supervisors / Operators. </li></ul></td></tr>
<tr>
  <td class="style6">&nbsp;</td>
</tr>
<tr>
<td class="style6">For handling Credit Cards manually:</td></tr>
<tr class="style12">
<td >The Operator should not write down any PIN codes or CARD VALIDATION CODES &amp; VALUES ( CVC’s or CVV2, CID etc) or addresses. If such information is written down or noted somewhere, it should be immediately deleted after processing. The Operator should be fully aware of the companies Data Security Statement in regards to how the Customers Secure information is processed. </td>
</table>
  
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <td height="80" align="center"><input type="image" src="images/btn_close.jpg" onClick="document.getElementById('divGuide').style.display='none';" /></td>
    </tr>
  </table>
</div>
<div id="div_onlineLinks" class="div_onlineLinks" style="position:absolute; right:0px; top:125px; left:367px; width:278px; height:190px; overflow:hidden; display:none;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="5" rowspan="3"><img src="images/spacer.gif" alt="spacer" width="5" height="10" /></td>
      <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="231" height="34" class="txtBld_white">Online Links </td>
          <td width="37" align="right" valign="top" onClick="document.getElementById('div_onlineLinks').style.display='none';"><img src="images/btn_close_1.jpg" style="cursor:pointer;" onClick="document.getElementById('div_onlineLinks').style.display='none';" alt="X" width="37" height="15" /></td>
          </tr>
      </table></td>
      <td width="5" rowspan="3"><img src="images/spacer.gif" alt="spacer" width="5" height="10" /></td>
    </tr>
    <tr>
      <td height="130" valign="middle" class="divSub_onlineLinks"><table width="85%" height="130" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="33" class="horLine_ltOrange"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="26"><img src="images/blt_arw_1.jpg"  width="16" height="16" /></td>
              <td class="txtLink_black" onMouseOver="this.className='txtLinkOvr_black'" onMouseOut="this.className='txtLink_black'" style="cursor:pointer;" onClick="window.open('https://scr.socket.fransupport.com/webpages/Qs/releasenotes.html');">Qs Release Notes</td>
            </tr>
          </table></td>
        </tr>
		<tr>
          <td height="33" class="horLine_ltOrange"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="26"><img src="images/blt_arw_1.jpg"  width="16" height="16" /></td>
              <td class="txtLink_black" onMouseOver="this.className='txtLinkOvr_black'" onMouseOut="this.className='txtLink_black'" style="cursor:pointer;" onClick="window.open('http://www.saladcreations.net');">Salad Creations</td>
            </tr>
          </table></td>
        </tr>
        <tr>
          <td height="33" class="horLine_ltOrange"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="26"><img src="images/blt_arw_1.jpg"  width="16" height="16" /></td>
              <td class="txtLink_black" onMouseOver="this.className='txtLinkOvr_black'" onMouseOut="this.className='txtLink_black'" style="cursor:pointer;" onClick="window.open('http://netsolace.bomgar.com');">Bomgar Support</td>
            </tr>
          </table></td>
        </tr>
        <tr>
          <td height="33" class="horLine_ltOrange"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="26"><img src="images/blt_arw_1.jpg"  width="16" height="16" /></td>
              <td class="txtLink_black" onMouseOver="this.className='txtLinkOvr_black'" onMouseOut="this.className='txtLink_black'" style="cursor:pointer;" onClick="window.open('http://qa.netsolace.com');">Netsolace Inc.</td>
            </tr>
          </table></td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td><img src="images/spacer.gif" alt="spacer" width="5" height="10" /></td>
    </tr>
  </table>
</div>
<div id="content_backup" style="display:none;"></div>
<div id="divLoading" style="display:none">
 <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
 <tr><td valign="middle" align="center" class="SimpleSmall"><img src="images/indicator.gif"><br>Loading...</td></tr>
 </table>
</div>
<map name="Map" id="Map"><area shape="rect" coords="579,-1,615,11" href="#" onClick="document.getElementById('divGuide').style.display='none';" /></map>
</body>
</html>
<%
	rstProducts.Close
	rstWeeklyImage.Close
	rstTreats.Close
	rstNews.Close
	rstTip.Close
	conDB.Close
	Set rstProducts = Nothing
	Set rstNews = Nothing
	Set rstTip = Nothing
	SEt rstWeeklyImage = Nothing
	Set rstTreats = Nothing
	Set conDB = Nothing
%>
