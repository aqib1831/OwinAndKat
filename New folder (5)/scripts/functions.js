/*************************************************************
/*  Page Level Functions for Page Controls
***************************************************************/
//Function to change the class
function changeClass(element, className)
{
	element.className = className;
}

//Functon to get X-poisition of element 
function getRealLeft(element)
{
	var position = element.offsetLeft;
	var parent = element.offsetParent;
	while (parent != null)
		{
		position += parent.offsetLeft;
		parent = parent.offsetParent;
		}
	return position;
}


//Functon to get y-poisition of element 

function getRealTop(element)
{
		var position = element.offsetTop;
		var parent = element.offsetParent;
		while (parent != null)
		{
				position += parent.offsetTop;
				parent = parent.offsetParent
		}
		return position;
}

//Function to get Element by ID
function getElement(id)
{
	if (document.layers)            // Netscape 4
		return eval("document." + id);
	if (document.getElementById)    // Netscape 6
		return eval("document.getElementById('" + id + "')");
	if (document.all)               // IE4+
		return eval("document.all." + id);
}


//Function to get All Elements by a Patern

function getElementsByIdPattern(root, pattern)
{
	var allEls = root.all;
	var regEx = eval('/' + pattern + '/');
	var filteredEls = new Array();
	var n = 0;
	for (var i=0; i<allEls.length; i++)
		if (regEx.test(allEls[i].id) == true)
			filteredEls[n++] = allEls[i];
	return filteredEls;
}

//Function to get All Elements by a Patern and Tag Name

function getElementsByTagNameAndIdPattern(root, tagName, pattern)
{
  var allEls = root.getElementsByTagName(tagName);
  var regEx = eval('/' + pattern + '/');
  var filteredEls = new Array();
  var n = 0;
  for (var i=0; i<allEls.length; i++)
    if (regEx.test(allEls[i].id) == true)
      filteredEls[n++] = allEls[i];
  return filteredEls;
}

function setSelectControlsVisibility(obj)
{
	try
		{
			var x = getRealLeft(obj);
			var y = getRealTop(obj);
			var w = obj.offsetWidth;
			var h = obj.offsetHeight;
			var selx,sely,selw,selh,i 
			var sel=document.getElementsByTagName("SELECT") 
			for(i=0;i<sel.length;i++)
			{ 
				selx=0; sely=0; var selp; 
				if(sel[i].offsetParent)
				{ 
					selp=sel[i]; 
					while(selp.offsetParent)
					{ 
						selp=selp.offsetParent; 
						selx+=selp.offsetLeft; 
						sely+=selp.offsetTop; 
					} 
				 } 
				selx+=sel[i].offsetLeft; 
				sely+=sel[i].offsetTop; 
				selw=sel[i].offsetWidth; 
				selh=sel[i].offsetHeight; 
				if(selx+selw>x && selx<x+w && sely+selh>y && sely<y+h) 
					if(sel[i].style.visibility!="hidden") sel[i].style.visibility="hidden"; 
					else sel[i].style.visibility="visible"; 
			} 
 		}
	catch (ex)
		{
		alert(ex.description);
		}
}



//Function used to hide/show all select boxes at page level
function setWindowedControlsVisibility(win, vis)
{
	try
		{
		var i;
		var els = win.document.getElementsByTagName("SELECT");
		if (vis.toLowerCase() == "hidden")
		  for (i=0; i<els.length; i++)
			{
			if (els[i].style != null && els[i].style.visibility != null)
				{
				els[i].lastVisibility = els[i].style.visibility;
				els[i].style.visibility = vis;
				}
			}
		else if (vis.toLowerCase() == "visible")
		  for (i=0; i<els.length; i++)
			{
			if (els[i].style != null && els[i].style.visibility != null)
				{				
				    if (els[i].lastVisibility != null) 
				    {
				        els[i].style.visibility = els[i].lastVisibility;
				    }    
				}
			}
		for (i=0; i<win.frames.length; i++)
		  setWindowedControlsVisibility(win.frames[i], vis);
		}
	catch (ex)
		{
		alert(ex.description);
		}
}

/*************************************************************
/*  Gneral Functions
***************************************************************/

function getNumberFromString(str)
{
	var strResult = "";
	var i;
	var blnNegative = false;
	
	// we consider only the '-' sign at start of the string to mark it negative; nowhere else.
	if (str.charAt(0)=='-') blnNegative = true;
	
  for (i=0; i < str.length; i++) 
	{
    if (str.charAt(i) == 0 || str.charAt(i) == 1 || str.charAt(i) == 2 || str.charAt(i) == 3 || str.charAt(i) == 4 || str.charAt(i) == 5 || str.charAt(i) == 6 || str.charAt(i) == 7 || str.charAt(i) == 8 || str.charAt(i) == 9 || str.charAt(i) == '.') 
			{
      	strResult += str.charAt(i);
      }
   }
	if (blnNegative==true) {
		return '-'+strResult;
	}else{
	  return strResult;
	}
}

function startsWith(str1, str2)
{
	if (str1.length < str2.length)
		return false;
	if (str1.substr(0, str2.length) == str2)
		return true
	else
		return false;
}

//added by khurram ali on 12-20-2005.
function formatAsPhoneNumber(str)
{
  // This function takes a string as parameter and format it
  // as USA phone number if it is a valid phone number else
  // it returns the original string.
  if (/^\d{10}$/.test(str)==true)
    return str.substr(0, 3) + "-" + str.substr(3, 3) + "-" + str.substr(6, 4)
  else
    return str;
}



function formatCurrency(num, currencySymbol) {
	//num = num.toString().replace(/\$|\,/g,'');
	var req = eval("/\\" + currencySymbol + "|\\,/g");
	num = num.toString().replace(req,'');
	if(isNaN(num))
	num = "0";
	sign = (num == (num = Math.abs(num)));
	num = Math.floor(num*100+0.50000000001);
	cents = num%100;
	num = Math.floor(num/100).toString();
	if(cents<10)
	cents = "0" + cents;
	for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
	num = num.substring(0,num.length-(4*i+3))+','+
	num.substring(num.length-(4*i+3));
	return (((sign)?'':'-') + currencySymbol + num + '.' + cents);
}

function initCaps(strText)
{
		var strName  = strText;
		strName = strName.toLowerCase();
		var firstChar;
		firstChar = strName.charAt(0);
		firstChar = firstChar.toUpperCase();
		strName =  strName.substring(1);
		strName = firstChar + strName; 
		return strName;
}

function generateRandomString(totalChars){
	var strDomain = 'abcdefghijklmnopqrstuvwxyz0123456789';
	var nLength = strDomain.length;
	var chrPos;
	var returnPass='';
	for (i=1;i<=totalChars;i++){
		chrPos = Math.floor(Math.random()*nLength);
		returnPass += strDomain.substr(chrPos,1);
		}
	return returnPass;
	}


/*
**************************************************************************
Grid Functions
***************************************************************************/
function initPaging(objGrid)
{
/*
			var RecordCount = (objGrid.rowCount());
			if (RecordCount == 0) 
			   {
				 getElement("DivInfo").style.display = 'inline';    // No Record Div
				 if (getElement("spnButtonsTop")!=null) getElement("spnButtonsTop").style.display = 'none';    // Next and previous Buttons Span
				 if (getElement("spnButtonsBottom")!=null) getElement("spnButtonsBottom").style.display = 'none';    // Next and previous Buttons Span
				 }
			if (RecordCount < objGrid.PageSize)
				{	 	
				if (getElement("lblNextTop")!=null) getElement("lblNextTop").style.display = 'none';       // next Button Label
				if (getElement("lblNextBottom")!=null) getElement("lblNextBottom").style.display = 'none';    // next Button Label
				}
			if (objGrid.PageStart == 0)
				{
				if (getElement("lblPreviousTop")!=null) getElement("lblPreviousTop").style.display = 'none';   // Previous Button Label
				if (getElement("lblPreviousBottom")!=null) getElement("lblPreviousBottom").style.display = 'none';   // Previous Button Label
				}
			if ((objGrid.PageStart == 0) && (RecordCount < objGrid.PageSize))	 
				{
				if (getElement("spnButtonsTop")!=null) getElement("spnButtonsTop").style.display = 'none';   
				if (getElement("spnButtonsBottom")!=null) getElement("spnButtonsBottom").style.display = 'none';   
				}


*/
			var RecordCount = (objGrid.rowCount());
			if (RecordCount == 0) 
			   {
				 getElement("DivInfo").style.display = 'inline';    // No Record Div
				 getElement("spnButtons").style.display = 'none';    // Next and previous Buttons Span
				 }
			if (RecordCount < objGrid.PageSize)
				 	//getElement("lblNext").style.display = 'none';       // next Button Label
					{
						getElement("lblNext").disabled = true;
						getElement("lblNext").style.cursor = 'default';
					}
			if (objGrid.PageStart == 0)
				  //getElement("lblPrevious").style.display = 'none';   // Previous Button Label
					{
					getElement("lblPrevious").disabled = true;
					getElement("lblPrevious").style.cursor = 'default';
					}
			if ((objGrid.PageStart == 0) && (RecordCount < objGrid.PageSize))	 
				  getElement("spnButtons").style.display = 'none';   
}

function showError(objGrid) 
{
			// shows eventual errors in an error span tag
			errorSpan.innerHTML=objGrid.lastError;
}


function GoPageNext(objGrid)
{
	if (getElement("lblNext").disabled == true )
	{
	 return false;
	}
	else
	{
	objGrid.PageNext();
		/*	if (getElement("lblPreviousTop")!=null) getElement("lblPreviousTop").style.display = 'inline';
			if (getElement("lblPreviousBottom")!=null) getElement("lblPreviousBottom").style.display = 'inline';
		*/
			//getElement("lblPrevious").style.display = 'inline';
	getElement("lblPrevious").disabled = false;
	getElement("lblPrevious").style.cursor = 'hand';
	}
				
}

function GoPagePrevious(objGrid)
{
	if (getElement("lblPrevious").disabled == true )
	{
	 return false;
	}
	else
	{
	objGrid.PagePrevious();
			/*if (getElement("lblNextTop")!=null) getElement("lblNextTop").style.display = 'inline'; 
			if (getElement("lblNextBottom")!=null) getElement("lblNextBottom").style.display = 'inline'; 
		*/
			//getElement("lblNext").style.display = 'inline'; 
	getElement("lblNext").disabled = false;
	getElement("lblNext").style.cursor = 'hand';
	}
}


function SelectedPageChange(objGrid)
{
	var RecordCount = (objGrid.rowCount());
	/*if (RecordCount < objGrid.PageSize)
		{
		if (getElement("lblNextTop")!=null) getElement("lblNextTop").style.display = 'none';  
		if (getElement("lblNextBottom")!=null) getElement("lblNextBottom").style.display = 'none';  
		}
	if (objGrid.PageStart == 0)
		{
		if (getElement("lblPreviousTop")!=null) getElement("lblPreviousTop").style.display = 'none';
		if (getElement("lblPreviousBottom")!=null) getElement("lblPreviousBottom").style.display = 'none';
		}
*/
	if (RecordCount < objGrid.PageSize)
			{
			//getElement("lblNext").style.display = 'none';
			getElement("lblNext").disabled = true;
			getElement("lblNext").style.cursor = 'default';  
			}
	else
			{
				getElement("lblNext").disabled = false;
				getElement("lblNext").style.cursor = 'hand';
			}	
	if (objGrid.PageStart == 0)
			{
			//getElement("lblPrevious").style.display = 'none';
			getElement("lblPrevious").disabled = true;
			getElement("lblPrevious").style.cursor = 'default';
			}

}


function ebaResizeGrid(gridId)
	{
	if (getElement(gridId) == null)
		return;
	var el;
	var i = 0;
	var colsTotalWidth = 0;
	var w = parseInt(getElement(gridId).offsetParent.offsetWidth, 10);
	var h = parseInt(getElement(gridId).offsetParent.offsetHeight, 10);
	getElement(gridId).width = w;
	getElement(gridId).height = h;
	while ((el = getElement("gcol_" + i)) != null)
		{
		colsTotalWidth += parseInt(el.width, 10);
		i++;
		}
	i--;
	if ((i >= 0) && ((w - colsTotalWidth - 20) > 0))
		getElement("gcol_" + i).width = parseInt(getElement("gcol_" + i).width, 10) + (w - colsTotalWidth - 20);
	}




/*
**************************************************************************
Combo Functions
***************************************************************************/

function ebaComboSelectById(strComboId, strId)
	{
	var objCombo = document.getElementById(strComboId).object;
	var objXml = objCombo.GetList().GetXmlDataSource();
	var n = objXml.GetNumberRows();
	for (var i=0; i<n; i++)
	  if (objXml.GetRow(i)[0] == strId)
		{
		objCombo.GetList().SetSelectedRow(i);
		objCombo.SetTextValue(objXml.GetRow(i)[1]);
		return true;
		}
	return false;
	}


function tabEvent(comboID) 
{
   var myCombo = document.getElementById(comboID).object;
   var temp = myCombo.GetList().m_ActiveRow;
   var vals = temp.id.split("_");
   var rowNum = vals[vals.length-1];
   myCombo.GetList().SetSelectedRow(rowNum);
}



/*
**************************************************************************
Error Message Functions
***************************************************************************/

function errorMessageShow()
{
	eval(getElement('ErrorMessageDiv').onShow);
	getElement('ErrorMessageDiv').style.display = 'block';
	getElement('ErrorMessageClose').focus();
	eval(getElement('ErrorMessageDiv').AfterShow);
}


function errorMessageClose()
{
	eval(getElement('ErrorMessageDiv').onClose);
	eval(getElement('ErrorMessageDiv').BeforeClose);
	getElement('ErrorMessageDiv').style.display = 'none';
}

  function errorMessageGetOnShow()
    {
      return getElement('ErrorMessageDiv').onShow;
    }

  function errorMessageSetOnShow(objHandler)
    {
	getElement('ErrorMessageDiv').onShow = objHandler;
	/*
	if (typeof(objHandler) == "string")
      getElement('ErrorMessageDiv').onShow = eval("function() {\n " + objHandler + " \n} ");
    else if (typeof(objHandler) == "function")
      getElement('ErrorMessageDiv').onShow = objHandler;
	*/
    }

  function errorMessageGetOnClose()
    {
      return getElement('ErrorMessageDiv').onClose;
    }

  function errorMessageSetOnClose(objHandler)
    {
	getElement('ErrorMessageDiv').onClose = objHandler;
	/*
	if (typeof(objHandler) == "string")
      getElement('ErrorMessageDiv').onClose = eval("function() {\n " + objHandler + " \n} ");
    else if (typeof(objHandler) == "function")
      getElement('ErrorMessageDiv').onClose = objHandler;
	*/
	}

		
	function errorMessageSetAfterShow(objHandler)
	{
		getElement('ErrorMessageDiv').AfterShow = objHandler;
	}

	function errorMessageSetBeforeClose(objHandler)
	{
		getElement('ErrorMessageDiv').BeforeClose = objHandler;
	}

  function errorMessageGetInstruction()
    {
    return getElement('ErrorMessageInstruction').innerHTML;
    }

  function errorMessageSetInstruction(strInstruction)
    {
    getElement('ErrorMessageInstruction').innerHTML = strInstruction;
    }
    
  function errorMessageGetItems()
    {
    return getElement('ErrorMessageItems').innerHTML;
    }

  function errorMessageSetItems(strItems)
    {
    getElement('ErrorMessageItems').innerHTML = strItems;
    }

  function errorMessageSetPosition(x, y)
    {
    getElement('ErrorMessageDiv').style.left = x + 'px';
    getElement('ErrorMessageDiv').style.top = y + 'px';
	}

  function errorMessageSetSize(w, h)
    {
    getElement('ErrorMessageDiv').style.width = w + 'px';
    getElement('ErrorMessageDiv').style.height = h + 'px';
	}


/*************************************************************
/*  Validation Functions
***************************************************************/

function ValidateInput(curObj,fieldType,bTrim,bAllowNull,nMinLength)
{
	
	// Trims the fields if the value is true
	if( bTrim )
		TrimString(curObj);
	
	// Boolean - true if field is validated, otherwise false
	var bisVarified = false;

	// fieldType case...
	switch(fieldType)
	{
		case  0: bisVarified = ValidateNames(curObj);					break;
		case  1: bisVarified = ValidateCompanyName(curObj);				break;
		case  2: bisVarified = ValidateCityName(curObj);			 	break;
		case  3: bisVarified = ValidatePostCode(curObj);				break;
		case  4: bisVarified = ValidateID(curObj);						break;
		case  5: bisVarified = ValidateStreetBuildingAddress(curObj);	break;
		case  6: bisVarified = ValidateEmailAddress(curObj);			break;
		case  7: bisVarified = ValidateTelephoneNumber(curObj);			break;
		case  8: bisVarified = ValidateNumber(curObj);					break;
		case  9: bisVarified = ValidateFloatingPoint(curObj);			break;
		case 10: bisVarified = ValidatePassword(curObj);				break;
		default: alert("ValidateInput ERROR: Invalid fieldType value.");	return false;	
	}	

	// If field is a 'nullable' field and empty, then return true
	if( curObj.value == "" && bAllowNull )
		return true;

	// If field length is less than minimum length, the generate error, and set focus back to field
	// NOTE: If field is nullable and empty, then this code is never reached!
	if( curObj.value.length < nMinLength )
	{
		// Using field title in error generated.
		//alert( "No value, or value too small for " + curObj.title + ".\nThe value should at least be " + nMinLength + " in length." );
		//curObj.focus();
		return false;
	}
	
	// If field is not validate, then generate an error, and return false
	if( bisVarified == false )
	{
		//alert( "Incorrect value for " + curObj.title + "." );
		//curObj.focus();
		return false;
	}

	// True, if everything has been successful
	return true;
}


// Trims spaces, vertical/horizontal tabs, newline and carriage returns
// This function fixes the actual value in the text box
function TrimString(curObj)
{
	var re;
	re = /^[ \f\n\r\t\v]+/;
	curObj.value = curObj.value.replace(re,"");
	re = /[ \f\n\r\t\v]+$/;
	curObj.value = curObj.value.replace(re,"");
}

// Helper function for following validation functions
// Returns false if the value is not validated, otherwise true
function MatchRegExp(curObj,re)
{
	if( curObj.value.match(re) == null )
		return false;

	return true;	
}

function ValidateNames(curObj)
{
	var re;	
	re = /^[a-zA-Z]+(( |-)[a-zA-Z]+)*$/;
	
	return MatchRegExp(curObj,re);
}

function ValidateCompanyName(curObj)
{
	var re;	
	re = /^[a-zA-Z0-9]+(( )?((-|\.)( )?)?([a-zA-Z0-9]+|\(([a-zA-Z0-9]( )?(\.( )?)?)+\))(\.)?)*$/;

	if( MatchRegExp(curObj,re) == false )
		return false;

	return MatchRegExp(curObj,/[a-zA-Z]/);
}

function ValidateCityName(curObj)
{
	return ValidateNames(curObj);
}

function ValidatePostCode(curObj)
{
	var re;	
	re = /^[a-zA-Z0-9]+(( )?(-( )?)?[a-zA-Z0-9]+)*$/;

	return MatchRegExp(curObj,re);
}

function ValidateID(curObj)
{
	return ValidatePostCode(curObj);
}

function ValidateStreetBuildingAddress(curObj)
{
	var re;	
	re = /^(#( )?)?[a-zA-Z0-9]+(( )?((@|-|#|&|\.|,|\\|\/|')( )?)?[a-zA-Z0-9]+(.)?)*$/;

	return MatchRegExp(curObj,re);
}

function ValidateEmailAddress(curObj)
{
	var re;		
//	re = /^([A-Za-z0-9])+(\.([A-Za-z0-9])+|_([A-Za-z0-9])+)*@(([a-zA-Z0-9])+(_)?([a-zA-Z0-9])+)+((_|\.)?([a-zA-Z0-9])+)*\.([a-zA-Z]){2,}$/;
	re = /^([A-Za-z0-9])+(\.([A-Za-z0-9])+|(_|-)([A-Za-z0-9])+)*@(([a-zA-Z0-9])+(_)?([a-zA-Z0-9])+)+((_|\.|-)?([a-zA-Z0-9])+)*\.([a-zA-Z]){2,}$/;

	return MatchRegExp(curObj,re);
}

function ValidateTelephoneNumber(curObj)
{
	var re;		
	re = /^(\([a-zA-Z0-9]+((-|.| )[a-zA-Z0-9]+)*\))?( )?([a-zA-Z0-9]+((-|.| )[a-zA-Z0-9]+)*)+$/;

	return MatchRegExp(curObj,re);
}

function ValidateNumber(curObj)
{
	var re;
	re = /^[0-9]+$/;

	return MatchRegExp(curObj,re);
}

function ValidateInteger(curObj)
{
	var re;
	re = /^[+-]{0,1}[0-9]+$/;

	return MatchRegExp(curObj,re);
}

function ValidateFloatingPoint(curObj)
{
	var re;		
	re = /^([0-9])*(\.([0-9]){1,10})?$/


	return MatchRegExp(curObj,re);
}

function ValidatePassword(curObj)
{
	var re;		
	re =  /^\w+(( )?\w+)*$/ ///^\w+\d+(( )?\w+)*$/  //version 2  /^[a-zA-Z]+[0-9]+\w+(( )?\w+)*$///version 1 /^\w+(( )?\w+)*$/

	return MatchRegExp(curObj,re);
}




function IsValidTime(timeStr) {
// Checks if time is in HH:MM:SS AM/PM format.
// The seconds and AM/PM are optional.

var timePat = /^(\d{1,2}):(\d{2})(:(\d{2}))?(\s?(AM|am|PM|pm))?$/;

var matchArray = timeStr.match(timePat);
if (matchArray == null) {
alert("Time is not in a valid format.");
return false;
}
hour = matchArray[1];
minute = matchArray[2];
second = matchArray[4];
ampm = matchArray[6];

if (second=="") { second = null; }
if (ampm=="") { ampm = null }

if (hour < 0  || hour > 23) {
alert("Hour must be between 1 and 12. (or 0 and 23 for military time)");
return false;
}
if (hour <= 12 && ampm == null) {
if (confirm("Please indicate which time format you are using.  OK = Standard Time, CANCEL = Military Time")) {
alert("You must specify AM or PM.");
return false;
   }
}
if  (hour > 12 && ampm != null) {
alert("You can't specify AM or PM for military time.");
return false;
}
if (minute<0 || minute > 59) {
alert ("Minute must be between 0 and 59.");
return false;
}
if (second != null && (second < 0 || second > 59)) {
alert ("Second must be between 0 and 59.");
return false;
}
return true;
}

function leftTrim(string)
{
return string.replace(/^\s*/, "");
}

function rightTrim(string)
{
return string.replace(/\s*$/, "");
}

function trim(string)
{
return string.replace(/^\s*/, "").replace(/\s*$/, "");
}


///////////////////////////////Delete The selected records ///////////////////////////////

function onDelete(frm,objGrid,Msg)
{
	
	 var blnanyChecked = false;
	 var strMessage = "";
	 var rowCount = (objGrid.rowCount()); // # of rows in the grid

	 for (var i=0; i < rowCount; i++) 
	 {
		 if (objGrid.getCellValue(i,1) == true)
			{
				var ID = objGrid.getKey(i) ;
				if (blnanyChecked == false)
					{frm.hdnSelected.value = ID;}
				else
					{frm.hdnSelected.value = frm.hdnSelected.value+ "," + ID;}
		 		blnanyChecked = true;
			}
	  }

	if (blnanyChecked == false)
	{
		strMessage = strMessage + "<li>"+Msg+"</li>";
		errorMessageSetOnShow("setWindowedControlsVisibility(window, 'hidden')");
		errorMessageSetOnClose("setWindowedControlsVisibility(window, 'visible');");
		errorMessageSetItems(strMessage);
		errorMessageShow();
		return false;
	}
	else
	{
		if (confirm('Are you sure you want to perform this operation?'))
				{return true;}
		else
				{return false;}
	}			
}

/////////////////////////////// Misc. Functions ///////////////////////////////

function onColor(blah)
{
	blah.style.backgroundColor='#7797CA';
}

function offColor(blah)
{
	blah.style.backgroundColor='';
}
	
function getElementByClassName(classname)
{ 
    var inc=0; 
    var alltags=document.all? document.all : document.getElementsByTagName("*"); 
    for (i=0; i<alltags.length; i++){ 
        if (alltags[i].className==classname) 
        {
            return alltags[i];    
        }
    }
    return null;
}



var ClearTime;
var blnShowed;
blnShowed = false;

function moveit(spot)
{
    if (document.getElementById())
  {
	   var picture=document.FrachiseDetail;
       if (spot<11)
		  {
			picture.left= spot;
			spot+=10;
			ClearTime = setTimeout('moveit('+spot+')',0);
		   }
		   else 
			clearTimeout(ClearTime);      
    }
  if (document.getElementsByTagName("*"))
	  {
		   var picture=document.all.FrachiseDetail.style;
		   if (spot<11)
		   {
			picture.left= spot;
			if(spot == 0)
				spot+=1;
			else
				spot+=10;
			ClearTime = setTimeout('moveit('+spot+')',0);
		   }
		   else 
			clearTimeout(ClearTime);      
		}
}

function moveleft(spot)
{
    if (document.getElementById())
  {
        var picture = document.getElementById().FrachiseDetail;
       if (spot>-326)
      {
        picture.left= spot;
        spot-=10;
        ClearTime = setTimeout('moveleft('+spot+')',0);
       }      
	   else
	   {
	   	clearTimeout(ClearTime);
		try{setWindowedControlsVisibility(window, 'visible');}catch(e){}
	   }
    }
  
    if (document.getElementsByTagName("*"))
  	{
  	 var picture=document.all.FrachiseDetail.style;
  	     if (spot>-326)
    	  {
        	picture.left= spot;
			spot-=10;
    	    ClearTime = setTimeout('moveleft('+spot+')',0);
       	  }
		   else
		   {
			clearTimeout(ClearTime);
			try{setWindowedControlsVisibility(window, 'visible');}catch(e){}
		   }
	}
}

function showHideVital()
{

    
	if (blnShowed == false)
	{
	 
		setWindowedControlsVisibility(window, 'hidden');
		getElement('OpenProfile').style.display = 'none';
		getElement('CloseProfile').style.display = 'inline';
		moveit(-326);
		blnShowed = true;
	}
	else
	{
			getElement('CloseProfile').style.display = 'none';
			getElement('OpenProfile').style.display = 'inline';
			moveleft(10);
			
			blnShowed = false;
	}
}
 function validateIPAddress(inputString) {
     var re = /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/;
     //test the input string against the regular expression
     if (re.test(inputString)) {
       //now, validate the separate parts
       var parts = inputString.split(".");
       if (parseInt(parseFloat(parts[0])) == 0) {
         return false;
       }
       for (var i=0; i<parts.length; i++) {
         if (parseInt(parseFloat(parts[i])) > 255) {
           return false;
         }
       }
       return true;
     }
     else {
       return false;
     }
}

function CheckSpecailChar(val) {
	
    var iChars = "!@#$%^&*()+=_[]\\\';,./{}|\":<>?";
    for (var i = 0; i < val.length; i++) {
        if (iChars.indexOf(val.charAt(i)) != -1) {
            return true;
        }
    }
}

function CheckSpecailCharForManual(val) {
    var iChars = "!@#^&*+=_[]\\\;,./{}|\:<>?";
    for (var i = 0; i < val.length; i++) {
        if (iChars.indexOf(val.charAt(i)) != -1) {
            return true;
        }
    }
}

function CenterAlignDiv(divElement) {
    divElement.style.left = parseInt(parseInt(parseInt(document.body.clientWidth) - parseInt(divElement.style.width)) / 2);
    divElement.style.top = parseInt(parseInt(parseInt(document.body.clientHeight) - parseInt(divElement.style.height)) / 2);
}