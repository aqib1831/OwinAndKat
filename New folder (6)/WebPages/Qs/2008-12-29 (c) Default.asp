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

//function scrollUp(){
//	try{
//		EnableScroll();
//		var div = window.frames.scrIframe.iframeMain.MainDiv
//		if (div.clientHeight < div.scrollHeight)
//				div.scrollTop-=50;
//	}catch(ex){
//	}
//}
//
//function scrollDown(){
//	try{
//		EnableScroll();
//		var div = window.frames.scrIframe.iframeMain.MainDiv
//		if (div.clientHeight < div.scrollHeight)
//				div.scrollTop+=50;
//	}catch(ex){
//	}
//}


function EnableScroll()
{	


	var div = window.frames.scrIframe.iframeMain.MainDiv
	if (div.clientHeight < div.scrollHeight)
			{
			document.getElementById('imgUp').style.display = "inline";
			document.getElementById('imgDown').style.display = "inline";
			document.getElementById('imgUp2').style.display = "none";
			document.getElementById('imgDown2').style.display = "none";
			//document.getElementById('imgDown').src = "images/down_normal.png";
			}
	else
		 {
			document.getElementById('imgUp').style.display = "none";
			document.getElementById('imgDown').style.display = "none";
			document.getElementById('imgUp2').style.display = "inline";
			document.getElementById('imgDown2').style.display = "inline";

 			//document.getElementById('imgUp').src = "images/up_disabled.png";
			//document.getElementById('imgDown').src = "images/down_disabled.png";
		 }	
		 disableScrollButtons();	
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




var zxcTO;
var blnScroll = false;

function Scroll(id,dis,pos){
 var obj=window.frames.scrIframe.iframeMain.MainDiv; 
 obj.scrollTop = obj.scrollTop+dis;
 if (pos){obj.scrollTop=pos; }
 else {
 				if (blnScroll == true)
				{
 				zxcTO=setTimeout( function(){ Scroll(id,dis); },10); 
				}
			}
}

function ScrollEnd()
{
	blnScroll = false;
	clearTimeout(zxcTO);
	disableScrollButtons();
}

function disableScrollButtons()
    {
            var div =  window.frames.scrIframe.iframeMain.MainDiv; 
   	        //EnableLeftPanelScroll();
   	        if (div.scrollTop == 0)
   	        {
	                document.getElementById('imgUp').style.display = "none";
	                document.getElementById('imgUp2').style.display = "inline";
	        }
            else
	        {
		            document.getElementById('imgUp').style.display = "inline";
		            document.getElementById('imgUp2').style.display = "none";
	        }		
       	    
   	        if (parseInt(div.scrollHeight) - parseInt(div.clientHeight) == div.scrollTop)
   	        {
	                document.getElementById('imgDown').style.display = "none";
	                document.getElementById('imgDown2').style.display = "inline";
	        }
            else
	        {
	               document.getElementById('imgDown').style.display = "inline";
				   document.getElementById('imgDown2').style.display = "none";
	        }		
   	  
    }

</script>
<link href="style/style.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="../../scripts/functions.js"></script>
</head>

<body onLoad="window.setTimeout('EnableScroll()',1000);">
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
<div id="divGuide" class="div_border" style=" position:absolute; top:0px; left:0px; width:675px; height:715px; background:#D0DECF; overflow:hidden; display:none;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
    <tr>
      <td height="57" colspan="3"><img src="images/header_userGuide.jpg" width="667" height="57" border="0" usemap="#Map" /></td>
    </tr>
    <tr>
      <td align="center" valign="top" colspan="3">
        <table border="0" align="center" cellpadding="0" cellspacing="0" class="div_bgWhite" height="578" width="100%">
          <tr>
            <td><iframe id="scrIframe" src="https://qa.netsolace.com/portal/um/client/UMClientMain.aspx?CategoryID=2944.15KlSmJsYws" marginheight="0" marginwidth="0" scrolling="auto" height="100%" width="100%"></iframe></td>
          </tr>
        </table>
      </td>
    </tr>
	<tr>
	  <td width="30%">&nbsp;</td>
	  <td height="80" width="40%" align="center">
		  <input style="display:inline;" type="image" src="images/btn_close.jpg" onClick="document.getElementById('divGuide').style.display='none';" />
	  </td>
		  <td height="80" width="30%" align="right">
		            <input type="image" id="imgUp" src="images/up_normal.png" onMouseDown="this.src='images/up_pressed.png'; blnScroll = true;Scroll('window.frames.scrIframe.iframeMain.MainDiv',-4);" onMouseUp="this.src='images/up_normal.png'; blnScroll = false; ScrollEnd();"  onClick="return false;" style="display:none;" />
					<input type="image" id="imgUp2" src="images/up_disabled.png"  style="display:none;" onclick="return false;" />&nbsp;&nbsp;
					<input name="image" type="image" id="imgDown" onMouseDown="this.src='images/down_pressed.png'; blnScroll = true;Scroll('window.frames.scrIframe.iframeMain.MainDiv',4);" onMouseUp="this.src='images/down_normal.png'; blnScroll = false; ScrollEnd();" onClick="return false;"  src="images/down_normal.png" style="display:none;" />
						<input name="image" type="image" id="imgDown2" src="images/down_disabled.png" style="display:none;" onclick="return false;" />&nbsp;&nbsp;
					
					
					  <!--<input id="imgUp" style="display:inline;" type="image" src="images/btn_scrollUp.jpg" onClick="scrollUp();" />--></td>
					  		  <!--<td height="80" align="center"><input id="imgDown" style="display:inline;" type="image" src="images/btn_scrollDown.jpg" onClick="scrollDown();" /></td>-->
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
<map name="Map" id="Map"><area shape="rect" coords="579,-1,659,11" href="#" onClick="document.getElementById('divGuide').style.display='none';" /></map>
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