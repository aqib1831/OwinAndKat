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
<div id="divGuide" class="div_border" style=" position:absolute; top:20px; left:25px; width:623px; height:666px; background:#D0DECF; overflow:hidden; display:none">
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
                <table width="100%" border="0" cellspacing="0" cellpadding="0" align="Center" height="100%">
                  <tr>
                    <td height="70" align="center"><img src="images/Netsolace_logo.jpg" alt="Netsolace INC" width="290" height="60" /></td>
                  </tr>
                  <tr>
                    <td >
                      <table width="100%" border="0" height="100%">
                        <tr>
                          <td align="center" height="50" style="font-size:20px;font-weight:bold;text-decoration:underline;">
                            Qs User Guide
                          </td>
                        </tr>
                        <tr>
                          <td><strong>1 Qs Main Home Page</strong></td>
                        </tr>
                    <tr>
                      <td><blockquote>
                        <p>Quickserve (Qs) home page is divided into three sections:</p>
                      </blockquote></td>
                    </tr>
                    <tr>
                      <td><strong>1.1 Qs Weekly Specials</strong></td>
                    </tr>
                    <tr>
                      <td><blockquote>
                        <p>All Qs weekly specials are listed on the left side of the screen.</p>
                      </blockquote></td>
                    </tr>
                    <tr>
                      <td><strong>1.2 Qs News</strong></td>
                    </tr>
                    <tr>
                      <td><blockquote>
                        <p>All Qs related  news is posted in the middle section of the home page screen, which is updated  by corporate office.<strong></strong></p>
                      </blockquote></td>
                    </tr>
                    <tr>
                      <td><strong>1.3 Qs Navigation Bar</strong></td>
                    </tr>
                    <tr>
                      <td><blockquote>
                        <p>The Quickserve  (Qs) software navigation bar is located on the right side of the home page and  acts as an access point for all necessary functions.<strong></strong></p>
                      </blockquote></td>
                    </tr>
                    
                    </table>
                    </td>
                  </tr>
                  <tr>
                    <td >
                      <table width="100%" border="0" height="100%">
                        
                        <tr>
                          <td><strong>2 Employee Time Management</strong></td>
                        </tr>
                        <tr>
                          <td><strong>2.1 Clock-In and Clock-Out</strong></td>
                        </tr>
                        <tr>
                          <td><blockquote>
                            <p>Qs Functions are  only available to employees who are clocked-in to the Qs software.</p>
                          </blockquote></td>
                        </tr>
                        <tr>
                          <td><strong>2.1.2 Clock-In</strong></td>
                        </tr>
                        <tr>
                          <td><blockquote>
                            <p>Tap the <strong>Clock In </strong>button to bring up the  clock-in screen.&nbsp; Swipe the Employee card  or enter the Employee Pin to clock-in to Qs.<strong></strong></p>
                          </blockquote></td>
                        </tr>
                        <tr>
                          <td><strong>2.1.3 Clock-Out</strong></td>
                        </tr>
                        <tr>
                          <td><blockquote>
                            <p>Tap the <strong>Clock Out </strong>button to bring up the  clock-out screen.&nbsp; Swipe the Employee  card or enter the Employee Pin to clock-out of Qs.<strong></strong></p>
                          </blockquote></td>
                        </tr>
                    </table>
                    </td>
                  </tr>
                  <tr>
                    <td >
                      <table width="100%" border="0"  height="100%">
                      <tr>
                        <td><strong>3 Taking Qs Orders</strong></td>
                      </tr>
                      <tr>
                        <td><blockquote>
                          <p>Click or Tap on the <strong>New Orders</strong> button to place new orders within the system.</p>
                        </blockquote></td>
                      </tr>
                      <tr>
                        <td><strong>3.1 Taking an Order</strong></td>
                      </tr>
                      <tr>
                        <td><blockquote>
                          <p>Note: When  pressing the buttons on the touch-screen, make sure the selected button turns <strong>Blue.&nbsp; </strong>The program will record the selection only when the button turns  blue.</p>
                        </blockquote></td>
                      </tr>
                      <tr>
                        <td><blockquote>
                          <p>Click or Tap the <strong>New Order </strong>button and swipe your  employee card on the login screen or manually enter your pin to access order  screen:</p>
                        </blockquote></td>
                      </tr>
                      <tr>
                        <td><blockquote>
                          <p>1. Select  merchandise in the <strong>Category (1) </strong>section.<br />
</p>
                        </blockquote></td>
                      </tr>
                      <tr>
                        <td><blockquote>
                          <p>2. Select  size from the <strong>Size/Price (2) </strong>section.</p>
                        </blockquote></td>
                      </tr>
                      <tr>
                        <td><blockquote>
                          <p>3. Select  product from the <strong>Product (3) </strong>section.<strong> </strong></p>
                        </blockquote></td>
                      </tr>
                      <tr>
                        <td><blockquote>
                          <p>4. Select  <strong>Options (4) </strong>if available for  selected product.</p>
                        </blockquote></td>
                      </tr>
                      <tr>
                        <td><blockquote>
                          <p>5. The selected saleable merchandise will show up in the <strong>Receipt (5)</strong> section.</p>
                        </blockquote></td>
                      </tr>
                      <tr>
                        <td><strong>3.1.1 To edit quantities of same product</strong></td>
                      </tr>
                      <tr>
                        <td><blockquote>
                          <p>If the customer  places an order for the same product in multiple quantities follow the  procedure below:</p>
                        </blockquote></td>
                      </tr>
                      <tr>
                        <td><ul>
                          <li>Repeat selections from step 1 through 4.</li>
                        </ul></td>
                      </tr>
                      <tr>
                        <td><ul>
                          <li>Verify <strong>Receipt</strong> section reflects the selection.</li>
                        </ul></td>
                      </tr>
                      <tr>
                        <td><blockquote>
                          <blockquote>
                            <p>Or</p>
                          </blockquote>
                        </blockquote></td>
                      </tr>
                      <tr>
                        <td><ul>
                          <li>Select Product within Receipt section and click <strong>Quantity </strong>button to activate pad to edit  product quantity.&nbsp; Select number to reflect  total quantity of same product.<strong></strong></li>
                        </ul></td>
                      </tr>
                      <tr>
                        <td><ul>
                          <li>Verify <strong>Receipt</strong> section reflects the selection.</li>
                        </ul></td>
                      </tr>
                      <tr>
                        <td><strong>3.1.2 To add new product under same category and same size</strong></td>
                      </tr>
                      <tr>
                        <td><blockquote>
                          <p>If customer  places an order for a different product under the same category and same size,  follow the procedure below:</p>
                        </blockquote></td>
                      </tr>
                      <tr>
                        <td><ul>
                           <li>                     
                          Repeat selections from step 1 through 4.
						  </li>
                          </ul></td>
                      </tr>
                      <tr>
                        <td><ul>
                          Verify <strong>Receipt </strong>section reflects the order correctly.
                        </ul></td>
                      </tr>
                      <tr>
                        <td><strong>3.1.3 To add new product under same category and different size</strong></td>
                      </tr>
                      <tr>
                        <td><blockquote>
                          <p>If customer  places an order for a different product under the same category and different  size, follow the procedure below:</p>
                        </blockquote></td>
                      </tr>
                      <tr>
                        <td><ul>
                          <li>Repeat selections from step 1 through 4.</li>
                        </ul></td>
                      </tr>
                      <tr>
                        <td><ul>
                          <li>Verify <strong>Receipt</strong> section reflects the order correctly.</li>
                        </ul></td>
                      </tr>
                      <tr>
                        <td><strong>3.1.4 To remove selected products from order section</strong></td>
                      </tr>
                      <tr>
                        <td><blockquote>
                          <p>If the customer  changes their mind and would like to have a product removed from the order,  follow the procedure below:</p>
                          </blockquote></td>
                      </tr>
                      <tr>
                        <td><ul>
                          <li>Note: On a large  order, the desired product to remove may be found by using the <strong>Up </strong>and <strong>Down </strong>keys situated at the bottom of receipt section.</li>
                        </ul></td>
                      </tr>
                      <tr>
                        <td>
                         
                            <ul>
                              <li>                              Select product to be removed from <strong>Receipt </strong>section by utilizing the <strong>Up </strong>and <strong>Down </strong>keys.<strong></strong>
                                </li>
                          </ul></td>
                      </tr>
                      <tr>
                        <td>
                          
                            <ul>
                              <li>                              Click <strong>Remove </strong>button to remove selected product from the order.<strong></strong>
                                </li>
                          </ul></td>
                      </tr>
                      <tr>
                        <td><strong>3.1.5 To process a Complimentary order</strong></td>
                      </tr>
                      <tr>
                        <td><blockquote>
                          <p>Complimentary (Comp) order can be entered in two ways:</p>
                        </blockquote></td>
                      </tr>
                      <tr>
                        <td><strong>3.1.5.1 Before selecting any category</strong></td>
                      </tr>
                      <tr>
                        <td><ul>
                          <li>Press the <strong>comp </strong>button before selecting any category.</li>
                        </ul>
                        </td>
                      </tr>
                      <tr>
                        <td>Repeat selections from step 1 through 4.</td>
                      </tr>
                      <tr>
                        <td>Verify that the order will show up with the <strong>(Comp) </strong>caption.</td>
                      </tr>
                      <tr>
                        <td><strong>3.1.5.5 After category has been selected</strong></td>
                      </tr>
                      <tr>
                        <td><blockquote>
                          <p>Assuming that  product(s) have already been selected for the current order and are showing on  the <strong>Receipt </strong>section of the screen:</p>
                          </blockquote></td>
                      </tr>
                      <tr>
                        <td><ul>
                          <li>Tap or click on the desired item that will be  marked as <strong>Complimentary </strong>on the  Receipt section.</li>
                        </ul></td>
                      </tr>
                      <tr>
                        <td><ul>
                          <li>Click on the <strong>Comp </strong>button at the bottom of the Receipt section.</li>
                        </ul></td>
                      </tr>
                      <tr>
                        <td><ul>
                          <li>The item will be marked as <strong>Complimentary (Comp) </strong>within the Receipt section and that item&rsquo;s  price will be deducted from the total.</li>
                        </ul></td>
                      </tr>
                    </table>
                    </td>
                  </tr>
                  <tr>
                    <td >
                      <table width="100%" border="0"  height="100%">
                      <tr>
                        <td><strong>4 Processing Qs Orders</strong></td>
                      </tr>
                      <tr>
                        <td><blockquote>
                          <p>After the customer  has finished placing the order, select the <strong>Payment </strong>button to process payment.&nbsp; After  successfully processing an order, click <strong>Exit </strong>to return to taking new orders.</p>
                        </blockquote></td>
                      </tr>
                      <tr>
                        <td><strong>4.1 To edit order from Payment screen</strong></td>
                      </tr>
                      <tr>
                        <td><blockquote>
                          <p>Any necessary  changes to the order should be made before selecting the payment screen.&nbsp; Click <strong>Cancel </strong>on payment screen to go back and edit the order.</p>
                        </blockquote></td>
                      </tr>
                      <tr>
                        <td><strong>4.2 Process Payments</strong></td>
                      </tr>
                      <tr>
                        <td><blockquote>
                          <p>Payments can be  processed in three ways:</p>
                        </blockquote></td>
                      </tr>
                      <tr>
                        <td><strong>4.2.1 Cash</strong></td>
                      </tr>
                      <tr>
                        <td><blockquote>
                          <p><strong><em>Exact Amount:</em></strong><strong> </strong>If customer provides with the exact amount, select <strong>Exact Amount </strong>button and the transaction will process automatically.<strong></strong></p>
                        </blockquote></td>
                      </tr>
                      <tr>
                        <td><blockquote>
                          <p><strong><em>Quick Amount  Buttons: </em></strong>Below the exact amount button, there are buttons  that allow you to enter the most likely amounts the customer might give.&nbsp; The <strong>Amount  Tendered </strong>and <strong>Change Due </strong>amounts  will be displayed.&nbsp; Click <strong>OK </strong>to process payment.</p>
                        </blockquote></td>
                      </tr>
                      <tr>
                        <td><blockquote>
                          <p><strong><em>Pad: </em></strong>If  the above methods cannot be used for what the customer provides, click the  &ldquo;Pad&rdquo; button to open a number pad.&nbsp; Enter  the amount tendered and click OK.&nbsp; The <strong>Amount Tendered </strong>and <strong>Change Due </strong>amounts will be  displayed.&nbsp; Click <strong>OK </strong>to process payment.</p>
                        </blockquote></td>
                      </tr>
                      <tr>
                        <td><strong>4.2.2 Credit Card</strong></td>
                      </tr>
                      <tr>
                        <td><p><strong><u>IMPORTANT:</u></strong> Each franchisee has to check their credit card  company portal <strong>EVERY NIGHT</strong> to ensure  all credit card transactions have been settled.</p>
                        </td>
                      </tr>
                      <tr>
                        <td><p>They need to also <strong>VERIFY on a regular basis with their bank</strong> that the correct funds  were deposited in their bank account.
                          </p>
                        </td>
                      </tr>
                      <tr>
                        <td><p><strong><u>It is the franchisee&rsquo;s responsibility to reconcile their accounts.</u></strong>&nbsp; Errors related to third-party service providers such as merchant processing are completely unrelated to the Netsolace Qs software.  Neither Netsolace nor its software may be held responsible for these external errors.&nbsp; </p>
                        </td>
                      </tr>
                      <tr>
                        <td>All the steps above will  ensure that all major problems can be quickly identified and acted upon.</td>
                      </tr>
                      <tr>
                        <td><blockquote>
                          <p><strong>Swipe Credit Card:</strong></p>
                        </blockquote></td>
                      </tr>
                      <tr>
                        <td><ul>
                          <li> Swipe the credit card to automatically enter all  credit card information into the process screen.&nbsp; Click <strong>Process </strong>to process payment.&nbsp;
                          </li>
                        </ul></td>
                      </tr>
                      <tr>
                        <td>
                          
                            <ul>
                              <li>Card approval notification will display onscreen  and a receipt will print for signatures and one for customer to keep.
                              </li>
                        </ul></td>
                      </tr>
                      <tr>
                        <td><blockquote>
                          <p><strong>Manually Enter Credit Card:</strong></p>
                        </blockquote></td>
                      </tr>
                      <tr>
                        <td><ul>
                          <li>If the credit card information is entered manually, the system may require customer address information under <strong>AVS</strong> option to verify data.</li>
                        </ul></td>
                      </tr>
                      <tr>
                        <td><ul>
                          <li>Card approval notification will display onscreen and a receipt will print for signatures and one for the customer to keep.</li>
                        </ul></td>
                      </tr>
                      <tr>
                        <td><strong>4.2.2.1 Credit Card Declines</strong></td>
                      </tr>
                      <tr>
                        <td><blockquote>
                          <p>In case of credit card decline, a screen with following options will appear on a new <strong>Transaction Decline</strong> screen:</p>
                        </blockquote></td>
                      </tr>
                      <tr>
                        <td><strong>4.2.2.2 Try Another Credit Card</strong></td>
                      </tr>
                      <tr>
                        <td><blockquote>
                          <p>Selecting this option will bring back to payment screen to allow entering and processing payment with a different credit card.</p>
                        </blockquote></td>
                      </tr>
                      <tr>
                        <td><strong>4.2.2.3 Enter voice authorization</strong></td>
                      </tr>
                      <tr>
                        <td><blockquote>
                          <p>If there is no internet connectivity, the credit card will not be authorized. Call the credit card company to obtain a voice authorization number.</p>
                        </blockquote></td>
                      </tr>
                      <tr>
                        <td><ul>
                          <li>Click on Enter voice authorization to manually enter that number to process the order.</li>
                        </ul></td>
                      </tr>
                      <tr>
                        <td><ul>
                          <li>Click OK to process payment.</li>
                        </ul></td>
                      </tr>
                      <tr>
                        <td><strong>4.2.2.4 Void/Cancel Ticket</strong></td>
                      </tr>
                      <tr>
                        <td><blockquote>
                          <p>This option will allow voiding or canceling ticket in progress.</p>
                        </blockquote></td>
                      </tr>
                      <tr>
                        <td><strong>4.2.2.5 Change Payment Mode</strong></td>
                      </tr>
                      <tr>
                        <td><blockquote>
                          <p>Click this option to change payment mode to other available payment options.</p>
                        </blockquote></td>
                      </tr>
                      <tr>
                        <td><strong>4.2.3 Check</strong></td>
                      </tr>
                      <tr>
                        <td><blockquote>
                          <p><strong>Note:</strong> Customer should provide a check with the exact amount along with valid I.D. for processing.</p>
                        </blockquote></td>
                      </tr>
                      <tr>
                        <td><ul>
                          <li>Enter Check number and Bank name.</li>
                        </ul></td>
                      </tr>
                      <tr>
                        <td><ul>
                          <li>Click <strong>Process</strong> to process payment by check.</li>
                        </ul></td>
                      </tr>
                      <tr>
                        <td><strong>4.2.4 Gift Cards</strong></td>
                      </tr>
                      <tr>
                        <td><blockquote>
                          <p>Gift Cards can be used as a form of payment if the store is utilizing Nova as their credit card processing merchant.</p>
                        </blockquote></td>
                      </tr>
                    </table>
                    </td>
                  </tr>
				          <tr>
                  	<td >
           					  <table width="100%" border="0"  height="100%">
            <tr>
              <td><strong>5 Manager&rsquo;s Menu Access</strong></td>
            </tr>
            <tr>
              <td><blockquote>
                <p>To access manager&rsquo;s menu, tap the <strong>Manager&rsquo;s Menu</strong> button on the Home page and swipe manager&rsquo;s card. Only Supervisors and Managers have access to this section of software.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><strong>5.1 Manager&rsquo;s Menu ~ Administration:</strong> All administrative functions for the software are listed within this section.</td>
            </tr>
            <tr>
              <td><strong>5.1.1 Order History</strong></td>
            </tr>
            <tr>
              <td><ul>
                <li>Tap  on this icon to bring up the <strong>Last 10  orders</strong> that were processed.</li>
              </ul></td>
            </tr>
            <tr>
              <td>
                  <ul>
                    <li>                    Tap on <strong>View </strong>to  see transaction details and click <strong>Print </strong>to  re-print receipt.
                    </li>
                </ul></td>
            </tr>
            <tr>
              <td>
                  <ul>
                    <li><strong>Number Pad </strong>on the same screen provides the ability to search  orders by order number.
                    </li>
                </ul></td>
            </tr>
            <tr>
              <td><strong>5.1.2 Refund Order:</strong></td>
            </tr>
            <tr>
              <td><blockquote>
                <p>Refunds can only be applied for full amount of order.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Last 10 orders</strong> can also be accessed from the Refund Order screen by selecting available link on top right of screen.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><ul>
                <li>Enter <strong>Order No.</strong> to refund on Refund Order screen and hit enter.</li>
              </ul></td>
            </tr>
            <tr>
              <td><ul>
                <li>Pertaining order details will come up on the right side of screen.</li>
              </ul></td>
            </tr>
            <tr>
              <td><ul>
                <li>Enter <strong>Refund Reason</strong> in the provided field.</li>
              </ul></td>
            </tr>
            <tr>
              <td><ul>
                <li>Select <strong>Add items back to inventory</strong> if applicable.</li>
              </ul></td>
            </tr>
            <tr>
              <td><ul>
                <li>Tap <strong>Refund Order</strong> to apply a refund for selected order.</li>
              </ul></td>
            </tr>
            <tr>
              <td><strong>5.1.3 Balance Register:</strong></td>
            </tr>
            <tr>
              <td><p><strong><u>IMPORTANT:</u></strong> Each franchisee has to check their credit card  company portal <strong>EVERY NIGHT</strong> to ensure  all credit card transactions have been settled.</p></td>
            </tr>
            <tr>
              <td><p>They need to also <strong>VERIFY on a regular basis with their bank</strong> that the correct funds  were deposited in their bank account.</p></td>
            </tr>
            <tr>
              <td><p><strong><u>It is the franchisee&rsquo;s responsibility to reconcile their accounts.</u></strong>&nbsp; Errors related to third-party service providers such as merchant processing are completely unrelated to the Netsolace Qs software. Neither Netsolace nor its software may be held responsible for these external errors.&nbsp; </p></td>
            </tr>
            <tr>
              <td> All  the steps above will ensure that all major problems can be quickly identified  and acted upon.</td>
            </tr>
            <tr>
              <td><blockquote>
                <p>This option accesses the Balance register screen where it provides the ability to reconcile Cash, Checks, Gift Card transactions and Credit Card transactions. Register balance should be performed on all terminals and is required to occur before performing Dayend.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Note: Balance Register function should be performed on both terminals, Terminal_1 and Terminal_2, consecutively. It is imperative that Dayend should always be performed after performing the Balance Register function.</strong></p>
              </blockquote></td>
            </tr>
            <tr>
              <td align="right"><blockquote>
                <p>Hand Over option to switch cashiers/employees is also provided in this section. Hand over can be performed multiples times during the day, if needed.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><strong>5.1.3.1 Reconcile Cash:</strong></td>
            </tr>
            <tr>
              <td><ul>
                <li>Select <strong>Open Drawer</strong> to open drawer.</li>
              </ul></td>
            </tr>
            <tr>
              <td><ul>
                <li>Count Coins and Bills and enter them in their respective denominations.</li>
              </ul></td>
            </tr>
            <tr>
              <td><strong>5.1.3.2 Reconcile Credit Card Sales:</strong></td>
            </tr>
            <tr>
              <td><ul>
                <li>Mark Credit Card and Gift Card sales on screen against actual receipts and online batch.</li>
              </ul></td>
            </tr>
            <tr>
              <td><strong>5.1.3.3 Reconcile Checks:</strong></td>
            </tr>
            <tr>
              <td><ul>
                <li>Mark Check amounts on screen against checks on hand.</li>
              </ul></td>
            </tr>
            <tr>
              <td><strong>5.1.3 Dayend:</strong> Dayend has to be performed everyday to reconcile total sales for entire day. Dayend can only be performed once per day.</td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Note: Dayend process should be performed on the Master terminal, usually Terminal_1 if the store has two terminals.</strong></p>
              </blockquote></td>
            </tr>
            <tr>
              <td>Dayend is performed in the following four steps:</td>
            </tr>
            <tr>
              <td><ul>
                <li><strong>Reconcile All Terminals:</strong> To perform <strong>Dayend</strong>, all terminals should be reconciled first by performing the <strong>Balance Register</strong> function.</li>
              </ul></td>
            </tr>
            <tr>
              <td><blockquote>
                <p>Stores with 2 terminals, Terminal_1 and Terminal_2, should perform Balance Register function on both terminals consecutively.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p>Stores with just one terminal can perform Dayend after reconciling that terminal.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><ul>
                <li><strong>Close Online CC Batch:</strong> The Dayend process closes the credit card batch automatically.</li>
              </ul></td>
            </tr>
            <tr>
              <td><ul>
                <li><strong>Report Online Sales:</strong> This function sends the Daily Sales report to Socket Fransupport.</li>
              </ul></td>
            </tr>
            <tr>
              <td><ul>
                <li><strong>Backup:</strong> After each Dayend, the DB is backed up and saved on the master terminal. The backup is incremental where the same file is replaced at Dayend with the changes.</li>
              </ul></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Closeout Transaction Summary </strong>report is displayed after the Dayend process, which can be printed or exported to PDF or in an Excel format. This report is also accessible from <strong>Report Center</strong> under <strong>Deposits</strong> as <strong>Deposit Summary.</strong></p>
              </blockquote></td>
            </tr>
            <tr>
              <td><strong>5.1.4 Employee Center:</strong></td>
            </tr>
            <tr>
              <td><blockquote>
                <p>Employee center provides the ability to:</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><ul>
                <li>Manage all employees.</li>
              </ul></td>
            </tr>
            <tr>
              <td><ul>
                <li>Administer Employee cards and PINs.</li>
              </ul></td>
            </tr>
            <tr>
              <td><ul>
                <li>Manage employees&rsquo; Time records.</li>
              </ul></td>
            </tr>
            <tr>
              <td><ul>
                <li>Track Employee History</li>
              </ul></td>
            </tr>
            <tr>
              <td><ul>
                <li>Inactivate Employees</li>
              </ul></td>
            </tr>
            <tr>
              <td><strong>5.1.4 Report Center:</strong></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>5.1.4.1 Manage Access:</strong></p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p>This feature allows the manager to select reports that will be available to Supervisors to view.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>5.1.4.2 Available Reports:</strong></p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p>Report Center provides the ability to run reports based on predefined criteria.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong><u>Orders:</u></strong> Reports available under orders tab are:</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Orders List</strong>: All orders for specific date range are listed on this report.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Refunded Orders</strong>: All refunded orders for a defined date range are listed on this report.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Discounted Orders:</strong> All discounted orders for a defined date range are listed on this report.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Comp Items:</strong> This report lists complimentary orders for a defined date range.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Promotions Report:</strong> This report provides data for a defined date against the predefined promotion packages.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong><u>Inventory:</u></strong> Reports available under inventory tab are:</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Inventory Usage:</strong> This report lists inventory usage for defined date range.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Inventory On Hand:</strong> This report lists the entire inventory on hand for tracking.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Sales:</strong> Reports available under sales tab are:</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Sales Summary by Payment Type:</strong> This report lists sales summary based on payment type.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Sales by Category:</strong> This report lists sales based on the category of the products sold.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Sales by Category Detailed Report:</strong> This report lists sales for detailed categories for the products sold.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Sales by Hour:</strong> This report provides a real-time graphic view of sales by the hour.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Sales Amount by Hour:</strong> This report provides a real-time graphic view of sales amount by hour.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Store Sales Tax Summary:</strong> This report provides store sales tax summary.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Sales Tax Details:</strong> This report provides stores sales tax details.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Weekly Sales Report:</strong> This report provides weekly sales amount.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Store Sales Tax Summary:</strong> This report shows the total tax collected during a given period of time.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Sales Tax Details:</strong> This report provides a detailed report on taxes collected during a defined date range.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong><u>Employees:</u></strong> Reports available under employees tab are:</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Timing History:</strong> This report provides clock in and clock out history for all employees.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Employee Productivity:</strong> This report provides a list of orders taken, sales amounts and percentage of orders taken.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong><u>Deposits:</u></strong> Reports available under deposits tab are:</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Closeout Summary:</strong> This report lists the closeout deposit summary for a specific day.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Drawer Activity Report:</strong> This report lists all the drawer activities including all sales and hand over information.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><strong>5.1.6 Alerts:</strong></td>
            </tr>
            <tr>
              <td><blockquote>
                <p>Alerts section provides immediate alerts on the following Qs functions:</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Inventory (New Items Purchased):</strong> This shows alerts for any new items purchased and their quantity.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Refunded (Orders):</strong> This shows alerts for most recent orders that were refunded.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Inventory (Out of Stock Items):</strong> This shows alerts for items that are currently out of stock.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Employees (Late comers):</strong> This shows alerts for employees who have arrived late to work. This alert shows an employee as a late arrival if they sign-in after 9AM.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>5.2 Manager&rsquo;s Menu - Utility Functions:</strong> All settings for order processing, printing, sales tax, and royalty are defined within this section.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><p><strong>5.2.1 Store Information:</strong> Provides access to area where basic store operations data and other related settings can be defined:</p></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>General Information:</strong> Store #, Username and Password are entered on this screen for synchronization. All store related information automatically populates in the applicable fields on the right side of this screen.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Sales Tax:</strong> All applicable taxes and royalty percentage are defined on this screen. Also, enter your applicable <strong>Tax Rate</strong> in the applicable tax field. Verify that correct <strong>Royalty</strong> amount and percentage are showing in the applicable field.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Merchant Setup:</strong> Merchant number and password are entered for payment processing merchant on this screen.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Other Settings:</strong></p>
              </blockquote></td>
            </tr>
            <tr>
              <td><ul>
                <li>Allows the ability to <strong>set report printer</strong></li>
              </ul></td>
            </tr>
            <tr>
              <td><ul>
                <li>Allows the ability to edit <strong>message at bottom of all receipts</strong></li>
              </ul></td>
            </tr>
            <tr>
              <td><ul>
                <li>Allows the ability to turn on or off <strong>Price Synchronization</strong> function. Selecting this option as <strong>No</strong> would retain local prices and will not sync with prices for products with other stores</li>
              </ul></td>
            </tr>
            <tr>
              <td><ul>
                <li>Allows the ability to turn on or off <strong>AVS option</strong> for credit card processing</li>
              </ul></td>
            </tr>
            <tr>
              <td><strong>5.2.2 Terminal Settings:</strong> Allows the ability to change the terminal&rsquo;s default settings:</td>
            </tr>
            <tr>
              <td><ul>
                <li>Define Terminal Name under <strong>Terminal Identification</strong></li>
              </ul></td>
            </tr>
            <tr>
              <td><ul>
                <li>Select Receipt Printer under <strong>Receipt Printer</strong></li>
              </ul></td>
            </tr>
            <tr>
              <td><ul>
                <li>Enable Auto Receipt printing</li>
              </ul></td>
            </tr>
            <tr>
              <td><ul>
                <li>Change Beginning of Drawer Count amount</li>
              </ul></td>
            </tr>
            <tr>
              <td><ul>
                <li>Define <strong>maximum discount limit</strong> amount</li>
              </ul></td>
            </tr>
            <tr>
              <td><ul>
                <li><strong>Enable auto logout</strong> from order entry screen due to inactivity</li>
              </ul></td>
            </tr>
            <tr>
              <td><ul>
                <li>Define inactivity time to logout from order entry screen</li>
              </ul></td>
            </tr>
            <tr>
              <td><ul>
                <li>Pole Display default and thank you messages are entered within this function</li>
              </ul></td>
            </tr>
            <tr>
              <td><strong>5.2.3 Coupons</strong>: Coupons can be defined and managed from this section for discounts.</td>
            </tr>
            <tr>
              <td><strong>5.2.4 Backup/Restore:</strong> Allows the ability to backup and restore the database to the desired location.</td>
            </tr>
            <tr>
              <td><ul>
                <li><strong>Backup</strong> can be performed at any time by clicking the <strong>Backup Now</strong> button</li>
              </ul></td>
            </tr>
            <tr>
              <td><ul>
                <li><strong>Restore</strong> can be performed from a desired restore point</li>
              </ul></td>
            </tr>
            <tr>
              <td><strong>5.2.5 Manual CC Auth:</strong> This feature provides the capability to process manual sale or refunds.</td>
            </tr>
            <tr>
              <td><strong>5.2.6 Synchronize Online:</strong> This option synchronizes Qs data such as categories, sizes, products, options and prices online with Salad Creations corporate database.</td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Price synchronization is optional</strong> and can be set from the Store Information section of the Manager&rsquo;s menu</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><strong>5.2.7 Menu Settings:</strong> Allows the ability to enter custom merchandise that is being sold locally and not company wide.</td>
            </tr>
            <tr>
              <td><strong>5.3 Manager&rsquo;s Menu ~ Inventory:</strong> There are two types of Inventory managed at the store:</td>
            </tr>
            <tr>
              <td><ul>
                <li>Consumables: Consumables are non-perishable items. Consumables contain complimentary products such as straws, napkins etc.</li>
              </ul></td>
            </tr>
            <tr>
              <td><ul>
                <li>Merchandise: Merchandise includes all saleable inventories.</li>
              </ul></td>
            </tr>
            <tr>
              <td><strong>Inventory Items:</strong></td>
            </tr>
            <tr>
              <td><ul>
                <li>Lists all inventory on hand for managing and tracking purposes based upon merchandise and consumable types.</li>
              </ul></td>
            </tr>
            <tr>
              <td><ul>
                <li>Allows the ability to add, edit or delete Inventory item as Merchandise and Consumables in relation to their respective vendors.</li>
              </ul></td>
            </tr>
            <tr>
              <td><ul>
                <li>Allows the ability to specify <strong>Re-Order Point</strong> for all merchandise and consumable inventory items.</li>
              </ul></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Receive Inventory:</strong> Allows the ability to scan in the received inventory.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Vendors:</strong> Allows the ability to manage vendors</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><ul>
                <li>Lists all the current vendors for the store.</li>
              </ul></td>
            </tr>
            <tr>
              <td><ul>
                <li>Allows the ability to add, edit or delete vendors.</li>
              </ul></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Consumables:</strong></p>
              </blockquote></td>
            </tr>
            <tr>
              <td><ul>
                <li>Provides the ability to assign all consumables to their respective categories.</li>
              </ul></td>
            </tr>
            <tr>
              <td><ul>
                <li>Lists all the available consumables.</li>
              </ul></td>
            </tr>
            <tr>
              <td><p><strong>5.4 Manager&rsquo;s Menu ~ Prices &amp; Taxes:</strong> All settings in relation to prices and taxes are defined in this section.</p></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Pricing:</strong> All merchandise information is automatically synchronized online with corporate database.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><ul>
                <li>Prices can be edited individually to reflect store&rsquo;s set prices.</li>
              </ul></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Promotions:</strong> This screen is used to create and manage packages. Packages are a group of multiple products that can be discounted.</p>
              </blockquote></td>
            </tr>
            <tr>
              <td><blockquote>
                <p><strong>Taxes:</strong> No Tax is enabled on all merchandise, by default. <strong>Tax Name</strong> should be checked off to apply tax for each taxable product.</p>
              </blockquote></td>
            </tr>
          </table>      
				            </td>
                  </tr>
                  <tr>
                    <td height="1"><img src="images/spacer.gif" width="1" height="1"></td>
                  </tr>
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