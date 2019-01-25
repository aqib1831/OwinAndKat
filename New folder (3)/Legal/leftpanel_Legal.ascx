<%@ Control Language="VB" AutoEventWireup="false" CodeFile="leftpanel_Legal.ascx.vb"
    Inherits="Research_leftpanel_Research" %>
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="height: 100%;" bgcolor="#D8EAFC">
    <tr>
        <td style="height: 31px; background-color: #A0CDEE; font-size: 15px; font-weight: bold;
            padding: 5px; width: 90%; border-bottom: 1px solid #609BD3;" nowrap>
          
                        <asp:UpdatePanel ID="pnlUpdate" runat="server" >
                            <ContentTemplate>
                            
                            
            <span class="ExtraSmall">Search :<br>
                <input name="txtSearch" id="txtSearch" type="text" style="width: 90%;" onkeypress="if(event.keyCode==13){ onSearchClick();document.getElementById('txtSearch').value=''; return false;}"
                    maxlength="50" value="" class="GreyTextBox">
                <img src="../images/btn_go.gif" width="18" height="18" align="absmiddle" onclick="onSearchClick();document.getElementById('txtSearch').value='';return false;"
                    title="Click here to search">
            </span>
            </ContentTemplate>
                            <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="hlkLegal" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
        </td>
    </tr>
    <tr>
        <td valign="top">
            <table cellspacing="0" cellpadding="0" style="height: 100%; display: inline;" width="100%"
                id="tblMenu">
                <tr class="Calendar_Selected" onclick="onTRClick('./LegalHome.aspx',this);onTRSubClear();ReminderDiv.style.display='none';sub_settings.style.display='none';" id="trID_1">
                    <td align="center">
                        <div width="17" height="31" align="absmiddle" />
                    </td>
                    <td align="left" colspan="2" style="height: 31px">                      
                    <asp:LinkButton  ID="hlkLegal"  OnClick="GetReminder"  runat="server" Text="Legal Home">Legal Home</asp:LinkButton>   
                    <%--<asp:HyperLink ID="hlkLegal" runat="server" Text="Legal Home">Legal Home</asp:HyperLink> --%>           
                       <%-- <a href="#" id="legal" >Legal Home</a>--%>
                    </td>
                </tr>
                <tr onclick="onTRClick('./Legal_Case.aspx',this);onTRSubClear();ReminderDiv.style.display='none';sub_settings.style.display='none';" id="trID_2" class="Calendar_Normal">
                    <td align="center">
                        <div width="17" height="31" align="absmiddle" />
                    </td>
                    <td colspan="2" align="left" style="height: 31px">
                        <a href="#">Case Management</a>
                    </td>
                </tr>
                <tr onclick="onTRClick('./Legal_IP.aspx',this);onTRSubClear();ReminderDiv.style.display='none';sub_settings.style.display='none';" id="trID_3" class="Calendar_Normal">
                    <td align="center">
                        <div width="17" height="31" align="absmiddle" />
                    </td>
                    <td colspan="2" align="left" style="height: 31px">
                        <a href="#">Intellectual Property</a>
                    </td>
                </tr>
                <tr onclick="onTRClick('./FirmManagement.aspx',this);onTRSubClear();ReminderDiv.style.display='none';sub_settings.style.display='none';" id="trID_4" class="Calendar_Normal">
                    <td align="center">
                        <div width="17" height="31" align="absmiddle" />
                    </td>
                    <td colspan="2" align="left" style="height: 31px">
                        <a href="#">Firms/Vendors</a>
                    </td>
                </tr>
                <tr class="Calendar_Normal" id="trID_5" style="cursor:pointer;" onclick="onSettingsClick();">
                    <td align="center">
                        <div width="17" height="31" align="absmiddle" />
                    </td>
                    <td align="left" colspan="2" style="height: 31px">
                        <a href="#">Settings</a></td>
                </tr>
                <tr id="sub_settings" style="display: none;">
                    <td align="left" colspan="3" style="height: 31px">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="#ffffff">
                            <tr id="subTR1" onclick="onTRClick('./Legal_Settings_CaseType.aspx',trID_5);onTRSubClick(this);ReminderDiv.style.display='none';">
                                <td style="width: 10px; border-bottom: #e5f1fb 2px inset; height: 20px">&nbsp;
                                    </td>
                               <td class="GridArrowColumn" style="width: 10px; height: 20px; border-bottom: 2px inset #E5F1FB;">&nbsp;
                                    
                                </td>
                                <td style="font-size: 11px; font-family: Arial, Helvetica, Sans-Serif; text-align: left;
                            font-size: 12px; padding-left: 0.5em; border-bottom: 2px inset #E5F1FB; cursor: pointer;
                            height: 22px; padding-right: 0px; color:#144090;">
                                   <a href="#">Case Types</a></td>
                            </tr>
                            <tr id="subTR2" onclick="onTRClick('./Legal_Settings_CaseStatusType.aspx',trID_5); onTRSubClick(this);ReminderDiv.style.display='none';">
                                <td style="width: 10px; border-bottom: #e5f1fb 2px inset; height: 20px">&nbsp;
                                    </td>
                                <td class="GridArrowColumn" style="width: 10px; height: 20px; border-bottom: 2px inset #E5F1FB;">&nbsp;
                                    
                                </td >
                                <td style="font-size: 11px; font-family: Arial, Helvetica, Sans-Serif; text-align: left;
                            font-size: 12px; padding-left: 0.5em; border-bottom: 2px inset #E5F1FB; cursor: pointer;
                            height: 22px; padding-right: 0px;color:#144090;">
                                   <a href="#"> Case Status Types</a></td>
                            </tr>
                            <tr id="subTR3" onclick="onTRClick('./Legal_Settings_CaseActivityType.aspx',trID_5);onTRSubClick(this);ReminderDiv.style.display='none';">
                                <td style="width: 10px; border-bottom: #e5f1fb 2px inset; height: 20px">&nbsp;
                                
                                </td>
                                <td class="GridArrowColumn" style="width: 10px; border-bottom: #e5f1fb 2px inset;
                                    height: 20px;">&nbsp;
                                    
                                </td>
                                <td style="padding-right: 0px; padding-left: 0.5em; font-size: 12px; cursor: pointer;
                                    color: #144090; border-bottom: #e5f1fb 2px inset; font-family: Arial, Helvetica, Sans-Serif;
                                    height: 22px; text-align: left">
                                    <a href="#">Case Activity Types</a>
                                </td>
                            </tr>
                          <tr id="subTR4" onclick="onTRClick('./Legal_Settings_IPType.aspx',trID_5);onTRSubClick(this);ReminderDiv.style.display='none';">
                              <td style="width: 10px; border-bottom: #e5f1fb 2px inset; height: 20px">&nbsp;
                                  </td>
                               <td class="GridArrowColumn" style="width: 10px; height: 20px; border-bottom: 2px inset #E5F1FB;">&nbsp;
                                    
                                </td>
                                <td style="font-size: 11px; font-family: Arial, Helvetica, Sans-Serif; text-align: left;
                            font-size: 12px; padding-left: 0.5em; border-bottom: 2px inset #E5F1FB; cursor: pointer;
                            height: 22px; padding-right: 0px;color:#144090;">
                                    <a href="#">IP Types</a></td>
                            </tr>
                            <tr id="subTR5" onclick="onTRClick('./Legal_Settings_IPStatusType.aspx',trID_5);onTRSubClick(this);ReminderDiv.style.display='none';">
                                <td style="width: 10px; border-bottom: #e5f1fb 2px inset; height: 20px">&nbsp;
                                    </td>
                                <td class="GridArrowColumn" style="width: 10px; height: 20px; border-bottom: 2px inset #E5F1FB;">&nbsp;
                                    
                                </td>
                                <td style="font-size: 11px; font-family: Arial, Helvetica, Sans-Serif; text-align: left;
                            font-size: 12px; padding-left: 0.5em; border-bottom: 2px inset #E5F1FB; cursor: pointer;
                            height: 22px; padding-right: 0px; color:#144090;">
                                    <a href="#">IP Status Types</a></td>
                            </tr>
                            <tr id="subTR6" onclick="onTRClick('./Legal_Settings_IPActivityType.aspx',trID_5);onTRSubClick(this);ReminderDiv.style.display='none';">
                                <td style="width: 10px; border-bottom: #e5f1fb 2px inset; height: 20px">&nbsp;
                                
                                </td>
                                <td class="GridArrowColumn" style="width: 10px; border-bottom: #e5f1fb 2px inset;
                                    height: 20px; ">&nbsp;
                                    
                                </td>
                              <td style="font-size: 11px; font-family: Arial, Helvetica, Sans-Serif; text-align: left;
                            font-size: 12px; padding-left: 0.5em; border-bottom: 2px inset #E5F1FB; cursor: pointer;
                            height: 22px; padding-right: 0px; color:#144090;">
                                    <a href="#">IP Activity Types</a>
                                </td>
                            </tr>
                             <tr id="subTR7" onclick="onTRClick('./Legal_Settings_FirmType.aspx',trID_5);onTRSubClick(this);ReminderDiv.style.display='none';">
                                <td style="width: 10px; border-bottom: #e5f1fb 2px inset; height: 20px">&nbsp;
                                
                                </td>
                                <td class="GridArrowColumn" style="width: 10px; border-bottom: #e5f1fb 2px inset;
                                    height: 20px; ">&nbsp;
                                    
                                </td>
                              <td style="font-size: 11px; font-family: Arial, Helvetica, Sans-Serif; text-align: left;
                            font-size: 12px; padding-left: 0.5em; border-bottom: 2px inset #E5F1FB; cursor: pointer;
                            height: 22px; padding-right: 0px; color:#144090;">
                                    <a href="#">Legal Firm/Vendor Types</a>
                                </td>
                            </tr>
                            
                            
                            <tr id="subTR8" onclick="onTRClick('./Legal_Countries.aspx',trID_5);onTRSubClick(this);ReminderDiv.style.display='none';">
                                <td style="width: 10px; border-bottom: #e5f1fb 2px inset; height: 20px">&nbsp;
                                
                                </td>
                                <td class="GridArrowColumn" style="width: 10px; border-bottom: #e5f1fb 2px inset;
                                    height: 20px; ">&nbsp;
                                    
                                </td>
                              <td style="font-size: 11px; font-family: Arial, Helvetica, Sans-Serif; text-align: left;
                            font-size: 12px; padding-left: 0.5em; border-bottom: 2px inset #E5F1FB; cursor: pointer;
                            height: 22px; padding-right: 0px; color:#144090;">
                                    <a href="#">Countries</a>
                                </td>
                            </tr>
                            
                            <tr id="subTR9" onclick="onTRClick('./AdminAccess.aspx',trID_5);onTRSubClick(this);ReminderDiv.style.display='none';">
                               
                            </tr>
                            
                            
                            
                        </table>
                    </td>
        </tr>
        <tr>
            <td style="width: 13px" colspan="3">
            </td>
        </tr>
        </table>
        <table border="0" cellspacing="0" cellpadding="0" style="font-weight: bold; font-size: 12px;
            color: white; border-bottom: #000000 1px solid; height: 100%; width: 100%; display: none;"
            id="tblSearch">
            <tr height="28px">
                <td width="100%" style="cursor: default; font-weight: bold; font-size: 12px; background-image: url(images/bg_CellNormal_black.jpg);
                    color: white; border-bottom: #000000 1px solid;">
                    &nbsp;Search Results</td>
                <td width="35" valign="top" align="right" style="padding-top: 2px; padding-right: 2px;
                    font-weight: bold; font-size: 12px; background-image: url(images/bg_CellNormal_black.jpg);
                    color: white; border-bottom: #000000 1px solid; height: 20px;">
                    <img src="../images/closebox2.gif" onclick="closeSerach();"></td>
            </tr>
            <tr>
                <td colspan="2" valign="middle" align="center" style="width: 100%; height: 100%;">
                    <img id="ImgLoader" src="../images/actionbar_loader.gif" style="display: none;" />
                    <iframe id="frameSearch" src="blank.aspx" frameborder="0" height="100%" width="100%"
                        marginheight="0" marginwidth="0" style="display: inline;"></iframe>
                </td>
            </tr>
            <tr class="Calendar_Normal" height="31">
                <td colspan="2" align="center">
                    <input id="Close" name="Close" class="btnExtraSimple" type="button" value="Close"
                        style="width: 50px; height: 20px;" onclick="closeSerach();"></td>
            </tr>
        </table>
        </td>
    </tr>
</table>
<script type="text/javascript" language="javascript">
function onSettingsClick()
{

onTRClick('./Legal_Settings_CaseType.aspx',trID_5);
sub_settings.style.display='inline';
onTRSubClick(subTR1);
}

function onSearchClick()
{
    var chk=document.getElementById('txtSearch');
    var val=chk.value;
    if(val.length==0)
    {
        return;
    }
    else
    {
        document.getElementById("tblMenu").style.display='none';
        document.getElementById("tblSearch").style.display='inline';
        document.getElementById("frameSearch").src = 'Legal_search.aspx?Search='+ document.getElementById("txtSearch").value;
    }
}
function closeSerach()
{
document.getElementById("tblMenu").style.display='inline';
document.getElementById("tblSearch").style.display='none';
}
function GetReminder()
{

}
function onTRSubClear()
	{
		try{
			var TotalTR =7;
			for(var i=1; i<=TotalTR; i++)
			{
				
					{
					eval("subTR"+i).className = 'SimpleHomeRow';
					}
			}	
			return false;
		}catch(e)
		{
		alert(e.description);
		window.navigate('Legal_Settings_CaseType.aspx');
		}
   }
function onTRSubClick(TR)
	{
	   
		try{
			var TotalTR =9;
			TR.className = 'LeftSubmenuclick';
		
		
			for(var i=1; i<=TotalTR; i++)
			{
				if(TR.id != "subTR"+i)
					{
					eval("subTR"+i).className = 'SimpleHomeRow';
					}
			}	
			return false;
		}catch(e)
		{
		alert(e.description);
		window.navigate('Legal_Settings_CaseType.aspx');
		}
   }
	function onTRClick(Url, TR)
	{
	
	   
		try{
			parent.frameMain.location = Url;

			var TotalTR =5;
			TR.className = 'Calendar_Selected';
			for(var i=1; i<=TotalTR; i++)
			{
				if(TR.id != "trID_"+i)
					eval("trID_"+i).className = 'Calendar_Normal';
			}	
			return false;
		}catch(e)
		{
		alert(e.description);
		window.navigate('LegalHome.aspx');
		}
   }    
   
   function onPageLoadTRClick(id)
	{
	 
	    var TR =   document.getElementById(id);
	    if(TR == null) return;
		try{
			var TotalTR =5;
			TR.className = 'Calendar_Selected';
			for(var i=1; i<=TotalTR; i++)
			{
				if(TR.id != "trID_"+i)
					eval("trID_"+i).className = 'Calendar_Normal';
			}	
			onTRSubClear();
			
			//sub_settings.style.display='none';
			
			return false;
		}catch(e)
		{
		
		}
   }  
   
	  function ShowReminderDiv()
	  {
	 	   document.getElementById("ReminderDiv").style.display='inline';
	 	    document.getElementById("ReminderDiv1").style.display='inline';
	 	    
	 	    
	 	   
	  }
  function SetWin(){

    if (navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.toUpperCase().indexOf("MSIE 7.0") < 0){
        try{setWindowedControlsVisibility(window,'hidden');}catch(ex){}
    }
    document.getElementById("divDisable").style.display = 'inline';
    document.getElementById("divDisable").style.width = '100%';
    document.getElementById("divDisable").style.height = '100%';
    document.getElementById("ReminderDiv").style.top=(document.body.offsetHeight/2)-100;
    document.getElementById("ReminderDiv").style.left=(document.body.offsetWidth/2)-172;
    document.getElementById("ReminderDiv").style.display = 'inline';
    
}
function HideWin()
{    
    document.getElementById("ReminderDiv").style.display = 'none';
    document.getElementById("divDisable").style.display = 'none';
    if (navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.toUpperCase().indexOf("MSIE 7.0") < 0){
        try{setWindowedControlsVisibility(window,'visible');}catch(ex){}
    }
}
</script>
<div align="center" style="vertical-align:middle;">
<div id="divDisable" class="modalBackground"></div>

<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <Triggers>
    <asp:AsyncPostBackTrigger ControlID="btnSnooze" EventName="Click" /><asp:AsyncPostBackTrigger ControlID="btnDisMiss" EventName="Click" /></Triggers>
        <ContentTemplate>
<div id="ReminderDiv" align="center" style="border-right: black 1px solid; border-top: black 1px solid;
    display:none; border-left: black 1px solid; width: 344px; border-bottom: black 1px solid;
    position: absolute; top: 120px; height: 200px; background-color: #bde4b8;">
    
    <table id="Table1" border="0" cellpadding="0" cellspacing="0" style="display: inline;
       font-size: 12px; width: 100%; border-bottom: #000000 1px solid;
        height: 100%">
        <tr>
            <td height="28" style="font-weight: bold; font-size: 12px; background-image: url(images/bg_CellNormal_black.jpg);
                cursor: default; color: white; border-bottom: #000000 1px solid" width="100%">
                &nbsp;<img onclick="setWindowedControlsVisibility(window,'visible');HideFranSearch();"
                    src="../images/icn_reminder.gif" align="absMiddle" height="15" width="14" />&nbsp; Reminder</td>
        </tr>
        <tr>
            <td colspan="2" height="31" style="padding-left: 5px; border-bottom: #50af43 1px solid">
                <i>Following Activity needs your attention...</i></td>
        </tr>
        <tr>
            <td bgcolor="#daf5d6" colspan="2" style="border-right: 0px; border-top: #000000;
                border-left: 0px; border-bottom: #50af43 1px solid" valign="middle" align="center">
               <table width="90%">
               <tr>
                   <td height="21" width="20">
                       <asp:Image ID="reminderImg" runat="server" Height="18px" Width="18px" /></td>
                   <td>
                       <asp:LinkButton ID="lnkReminderActivity" runat="server"><asp:Label ID="lblActivityName" runat="server" EnableViewState="False"></asp:Label></asp:LinkButton>
                   </td>
                   </tr>
               </table>
               
               </td>
        </tr>
        <tr style="background-color: #bde4b8">
            <td align="center" colspan="2" height="15" style="padding-bottom: 5px; padding-top: 5px">
                 <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <i>Remind me after&nbsp;</i>
                            <asp:DropDownList ID="ddlSnoozeTime" runat="server" ><asp:ListItem Value="1">05 mins</asp:ListItem><asp:ListItem Value="2">10 mins</asp:ListItem><asp:ListItem Value="3">15 mins</asp:ListItem><asp:ListItem Value="4">30 mins</asp:ListItem><asp:ListItem Value="5">45 mins</asp:ListItem><asp:ListItem Value="6">01 hour</asp:ListItem><asp:ListItem Value="7">02 hours</asp:ListItem><asp:ListItem Value="8">05 hours</asp:ListItem><asp:ListItem Value="9">10 hours</asp:ListItem><asp:ListItem Value="10">01 day</asp:ListItem><asp:ListItem Value="11">02 days</asp:ListItem><asp:ListItem Value="12">03 days</asp:ListItem><asp:ListItem Value="13">01 week</asp:ListItem></asp:DropDownList>
                            &nbsp;
               </td>
                        <td style="BORDER-RIGHT: #50af43 1px solid;" ><asp:Button ID="btnSnooze" runat="server" CssClass="btnGreen" Text="Snooze" OnClientClick="HideWin()" />&nbsp;&nbsp;
                        </td>
                        <td> &nbsp;&nbsp;<asp:Button ID="btnDisMiss" runat="server" CssClass="btnGreen" Text="Dismiss" OnClientClick="HideWin()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </div>
</ContentTemplate>
  </asp:UpdatePanel>
</div>


