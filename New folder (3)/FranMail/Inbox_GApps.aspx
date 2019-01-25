<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Inbox_GApps.aspx.vb" Inherits="FranMail_Inbox_GApps" %>
<%@ Register Assembly="RadGrid.Net2" Namespace="Telerik.WebControls" TagPrefix="radG" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Fran Mail</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js" ></script>
</head>
<body style="margin:0px; overflow:auto;">
    <form id="form1" runat="server">
        <asp:HiddenField ID="hdnUnSeenEmailCount" runat="server" />
        <asp:HiddenField ID="hdnMailBox" runat="server" />
        <asp:HiddenField ID="hdnMailHost" runat="server" />
        <asp:HiddenField ID="hdnPopUsername" runat="server" />
        <asp:HiddenField ID="hdnPopPassword" runat="server" />
    <div id="divDisable" class="modalBackground" ></div>
    
    <div id="DivIFrame" style="display:none;border:solid 1px #000000; position:absolute; width:800px; height:90%; top:5%; left:10%; z-index:10000;">
      <table style="height:100%;" cellpadding="0" border="0" cellspacing="0"   >
       <tr >    
          <td align="left" style="vertical-align:middle; border-bottom:solid 1px #000000; background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%;">
          	<span style="color:#FFFFFF; font-size:12pt;"><b>&nbsp;Email Detail</b></span>
          </td>
          <td  style="border-bottom:solid 1px #000000;background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%; height:28px; cursor:pointer;">
              <img src="../images/win_btn_close_black.jpg" style="float:right;" alt="Close Window" onClick="CloseMailDetailDiv();" />
          </td>               
       </tr>
       <tr valign="top">                
         <td colspan="2" style="height:100%; padding:0px; font-size:12px; background-color:White; border:0px;" >   
            <div id="divInnerIframe" style="overflow:auto; height:400px; width:600px; border:0px;" >   
                <iframe name="IFMailDetail" id="IFMailDetail" src="blank.aspx" style="margin: 0px;width:100%;height:100%;border:0px" scrolling="no" frameborder="0"></iframe>
            </div>
         </td>
       </tr>            
      </table>
    </div>
    
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <asp:UpdateProgress ID="Progress1" runat="server">
        <ProgressTemplate>
            <div class="ProgressIndicatorDIV" style="width:150px; bottom: 10px;" >
                <br />
                <asp:Image ID="Image2" runat="server" ImageUrl="~/images/indicator.gif" ImageAlign="AbsMiddle" /> <span style="color:#4B92C1;font-size:14px;"><b>&nbsp;&nbsp;Loading ...</b></span>
                <br /><br />
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <div>
    <table cellpadding="0" cellspacing="0" border="0" style="width:100%;height:100%;">
            <tr style="background-color:#A0CDEE; padding:3px; font-size:14px;">
                <td style="height:31px;width:75%;padding-left:0.5em;border-bottom:1px solid #609BD3;">
                       
                       <table cellpadding="0" cellspacing="0" border="0" width="100%" height="100%" class="tt">
                        <tr>
                            <td><b>Email Log</b>
                <asp:Label ID="lblPageTitle" runat="server" Visible="false"></asp:Label>&nbsp;[<asp:Label ID="lblEmailAddress" runat="server" Text=""></asp:Label>]&nbsp;
                       <asp:DropDownList ID="InboxType" runat="server" AutoPostBack="true" Font-Size="XX-Small">
                        <asp:ListItem Value="Inbox" Text="Inbox"></asp:ListItem>
                        <%--<asp:ListItem Value="Sent" Text="Sent Mail"></asp:ListItem>--%>
                       </asp:DropDownList>
                       <asp:Button runat="server" ID="btnRefreshNew" Text="Refresh" ToolTip="Refresh" CssClass="Btn3D" Height="20" />
                </td>
                            
                        </tr>
                       </table>

                       
                    </td>
                    <td style="border-bottom:1px solid #609BD3;" align="right">
                        <input type="button" value="Login To Google Apps" title="Login To Google Apps" onClick="window.open('login_skf.html');" style="width:150px; height:20px;" class="Btn3D" />
                   </td>
            </tr>
            <tr style="display:none;">
                <td colspan="2" style="background-color:#BADCFC; ">
                    <table style="display:none;">
                        <tr>
                            <td>
                                <span class="GreyTextSmall">Status:</span>
                                <asp:DropDownList ID="ddlStatus" runat="server" SkinID="SmallTextCombo" AutoPostBack="true"> 
                                    <asp:ListItem Value="0" Text="UnSeen"></asp:ListItem> 
                                    <asp:ListItem Value="1" Text="Seen"></asp:ListItem> 
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                    &nbsp;
                </td>
            </tr>
            <tr style="display: none;">
            <td style="display: none;">
               <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                   <ContentTemplate>
                        &nbsp;&nbsp;<font style="font-size:12px;">Select&nbsp;:</font><a href="#" style="font-size:12px" onClick="CheckAll();">All</a>
                        <div id="divError" runat="server" style="display:none;background-color:#FFF59F; border:solid 1px #D4C01B ">
                            <span style="color:Red; font-weight:bold;  font-size:10px;">There was a problem!</span>
                            <span style="color:Black; font-size:10px;" >
                                No message selected. Please select at least one message and try again
                            </span>
                       </div>
                    </ContentTemplate>
              </asp:UpdatePanel>
             </td> 
                <td align="right" style="display: none;">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <asp:Button ID="btnDelete" runat="server" Text="Delete Checked" CssClass="btn3d" Width="150px" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr style="height:100%; width:100%;">
                <td style="background-color: #E4F1F7;">
                    <div style="overflow:auto; height:100%; width:100%; background-color:#E4F1F7;border:1px solid #ACBDD5;"  id="Div1">
                        <asp:UpdatePanel ID="UPMain" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                 <radG:RadGrid ID="gvInbox" runat="server" AllowCustomPaging="True" AllowPaging="True" AutoGenerateColumns="False" Skin="FransupportBlue" AllowSorting="True">
                                <MasterTableView DataKeyNames="ID" Skin="FransupportBlue" ShowHeadersWhenNoRecords="False">
                                <PagerStyle CssClass="FloatingPager" Visible="false" Mode="NumericPages"  />
                                 <NoRecordsTemplate>                                                  
                                 <div id="RadGriddivInfo" style="display:visible;position: absolute; width:200px; height:50px; left:35%; top:38%;" class="MessageDiv"> 
                                 <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height:50px;">                                                   
                                    <tr>
                                        <td style="width:5%;" >&nbsp;</td>
                                        <td align="right" valign="middle" style="width:25%;">
                                            <div style="text-align:right;">
                                                <asp:Image ID="Image1" runat="server" ImageUrl="~/images/ico_alert.gif" />&nbsp;&nbsp; 
                                            </div>
                                        </td>
                                        <td nowrap="nowrap" align="left" valign="middle" id="divMessage" style="width:75%;font-size:8pt;">&nbsp;No Record Found</td>
                                    </tr>
                                 </table>
                             </div>                                                                                      
                             </NoRecordsTemplate>
                                <Columns>
                                <radG:GridTemplateColumn UniqueName="TemplateColumn">
                                     <ItemTemplate>
                                         <img src="../images/arrows.gif" />
                                     </ItemTemplate>
                                     <ItemStyle Width="2%" />
                                </radG:GridTemplateColumn>
                                <radG:GridTemplateColumn UniqueName="TemplateColumn6" Visible="false" >
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkEmail" runat="server" AutoPostBack="false" onclick="Check(this);" Visible="false" />
                                </ItemTemplate>
                                <ItemStyle />  
                                </radG:GridTemplateColumn>
                                <radG:GridTemplateColumn UniqueName="TemplateColumn1" Visible=false>
                                     <ItemTemplate>
                                               <img src='<%= ConfigurationManager.AppSettings("ImagesURL") %><%# EmailSeen(Eval("EmailSeen")) %>' alt="<%#IIf(CInt(Eval("EmailSeen"))=1,"Seen Message","UnSeen Message") %>"  />&nbsp;
                                               <img src='<%= ConfigurationManager.AppSettings("ImagesURL") %><%# EmailAttachment(Eval("NumAttachments")) %>' style="display:<%#IIf(CInt(Eval("NumAttachments"))>0,"inline","none") %>" alt="<%#IIf(CInt(Eval("NumAttachments"))=1,"Attachment","Attachments") %>"  />&nbsp;
                                     </ItemTemplate>
                                </radG:GridTemplateColumn>
                                <radG:GridTemplateColumn HeaderText="ID" SortExpression="ID" Visible="False" UniqueName="TemplateColumn2">
                                    <ItemTemplate>
                                                <asp:Label ID="lblEmailSeen" runat="server" Text='<%#Eval("EmailSeen") %>'></asp:Label>
                                                <asp:Label ID="lblNumAttachment" runat="server" Text='<%#Eval("NumAttachments") %>'></asp:Label>
                                   </ItemTemplate>
                                   </radG:GridTemplateColumn> 
                                <radG:GridTemplateColumn HeaderText="From" SortExpression="From" UniqueName="TemplateColumn3">
                                     <ItemTemplate >
                                      <asp:Label ID="lblID" runat="server" Text='<%#Eval("ID") %>' Visible="false" ></asp:Label>
                                        <asp:Label ID="lblFrom" runat="server" ToolTip='<%#Container.DataItem("FromAddress") %>' Text='<%#Functions.StringTruncate(Container.DataItem("From"),85) %>'></asp:Label>
                                     </ItemTemplate> 
                                     <ItemStyle Width="22%" />
                                </radG:GridTemplateColumn>
                                <radG:GridTemplateColumn HeaderText="Subject" SortExpression="Subject" UniqueName="TemplateColumn4">
                                    <ItemTemplate >
                                            <asp:Label ID="lblSubject" runat="server" ToolTip='<%#Container.DataItem("Subject") %>' Text='<%#Functions.StringTruncate(Container.DataItem("Subject"),55) %>'></asp:Label>
                                        </ItemTemplate>
                                    <ItemStyle Width="50%" />
                                </radG:GridTemplateColumn>
                                <radG:GridTemplateColumn HeaderText="Date" SortExpression="Date" UniqueName="TemplateColumn5">
                                    <ItemTemplate >
                                            <asp:Label ID="lblDate" runat="server" ToolTip='<%#Container.DataItem("Date") %>' Text='<%#Functions.StringTruncate(Container.DataItem("Date"),85) %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="20%" />
                                </radG:GridTemplateColumn>
                                </Columns> 
                                    <ExpandCollapseColumn Resizable="False" Visible="False">
                                        <HeaderStyle Width="20px" />
                                    </ExpandCollapseColumn>
                                    <RowIndicatorColumn Visible="False">
                                        <HeaderStyle Width="20px" />
                                    </RowIndicatorColumn>
                                </MasterTableView>
                                     <ExportSettings>
                                         <Pdf PageBottomMargin="" PageFooterMargin="" PageHeaderMargin="" PageHeight="11in"
                                             PageLeftMargin="" PageRightMargin="" PageTopMargin="" PageWidth="8.5in" />
                                     </ExportSettings>
                                     <PagerStyle Mode="NumericPages" />
                                </radG:RadGrid>
                            </ContentTemplate>
                            <Triggers>
                                 <asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click" />
                                 <asp:AsyncPostBackTrigger ControlID="ddlStatus" EventName="SelectedIndexChanged" />
                                 
                               </Triggers>
                        </asp:UpdatePanel> 
                        <asp:ObjectDataSource ID="odsInbox" runat="server" EnablePaging="True"   SortParameterName="sortExpression" SelectCountMethod="GetAllEmailCount" SelectMethod="GetMessageHeaders" TypeName="ImapServer" >
                        </asp:ObjectDataSource>
                        <asp:Button ID="btnRefresh" runat="server" style="visibility:hidden;display:none;" />
                        </div>
               </td>
               <td>
               <iframe frameborder="0" src="MailContacts.aspx" style="width:100%; height:100%;"></iframe>
               </td>
             </tr>
             <tr style="height:20px;background-color:#BADCFC;">
                <td align="right" id="CustomPagerRow" style="height:25px;" colspan="2" ></td>
            </tr>
        </table>
    </div>
    </form>
   <div id="ReportsDiv" style="display:none; border:solid 1px #BADCFC; position:absolute; height:100%; width:100%; top:0%;left:0%;" >
        <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
            <tr>
                <td style="height:100%;width:100%;">
                    <iframe id="iframeEmail" src="blank.aspx" scrolling="no" frameborder="0" style="margin: 0px;width:100%;height:100%;border:0px" runat="server"  ></iframe>
                </td>
            </tr>
       </table>
  </div>   
</body>
</html>
<script language="javascript" type="text/javascript"   >
var count;
  function AdjustPagerRow(){
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
    
    function pageLoaded(sender, args) {
        var updatedPanels = args.get_panelsUpdated();
        if (typeof(postbackElement) === "undefined") {
            return;
        } 
        for (i=0; i < updatedPanels.length; i++){
            if (updatedPanels[i].id == '<%= UPMain.ClientID %>') {
                AdjustPagerRow();
             }
        }
    }    
    function CheckAll()
    {
        var elements = document.getElementsByTagName("input");
        var grid = document.getElementById('<%=gvInbox%>');
        for (var index = 0; index<elements.length - 1 ;index++)
        {
            if (elements[index].type=="checkbox")
            {
                elements[index].checked = true;
                var ele = elements[index].parentElement.parentElement;
                if (elements[index].checked = true)
                {
                }
            }
        }
  }
  function Check(element)
  {
    
  }
  function ShowMessage(element)
  {
        var elements = document.getElementsByTagName("input");
        var flag = false;
        if  (element.options[element.selectedIndex].text == "Delete")
        {
            for (var index = 0; index<elements.length - 1 ;index++)
            {
                if (elements[index].type=="checkbox")
                {
                    if (elements[index].checked == true)
                    flag = true;
                }
            }
            if (flag ==false)
            {
                //alert('please select an email ');
                
            }
            return flag;
        }
  }
  function EmailCount()
  {
     count = 1;
     parent.EmailCount('<%=hdnUnSeenEmailCount.Value%>');
  }
  function ShowProgressBar()
  {
    alert('calling show bar');
    document.getElementById("<%=Progress1.ClientID %>").style.display = "inline";
  }
  function HideProgressBar()
  {
        alert('calling hide bar');
        document.getElementById("<%=Progress1.ClientID %>").style.display = "none";
  }
  function ShowEmailDetail(EmailID, EmailSeen, Folder)
  {
    if (EmailSeen==1)
    {
        ReportsDiv.style.display = "inline";
        ReportsDiv.style.width ="100%";
        ReportsDiv.style.height ="100%"; 
        iframeEmail.location.href = "Inbox_GApps_Details.aspx?Mailbox="+Folder+"&From=Inbox&ID="+EmailID; 
    }
    else
    {
        window.location ="Inbox_GApps_Details.aspx?Mailbox="+Folder+"&ID=" + EmailID; 
    }
  } 
  
  function OpenMailDetailDiv(EmailID, EmailSeen, Folder)
    {       
        IFMailDetail.location = "Inbox_GApps_Details.aspx?Mailbox="+Folder+"&ID=" + EmailID;
        var DivFram = document.getElementById('DivIFrame')
        var divInnerIframe = document.getElementById('divInnerIframe')
        divInnerIframe.style.width = '970px';
        DivFram.style.width = '970px';
        divInnerIframe.style.height = '500px';
        DivFram.style.height = '500px';
        DivFram.style.left = '2%';
        DivFram.style.height = '2%';
        document.getElementById('divDisable').style.width = '100%';
        document.getElementById('divDisable').style.height = '100%';
        document.getElementById('divDisable').style.display = 'inline';
        DivFram.style.display = "inline";
        divInnerIframe.style.display = "inline";
        try{setWindowedControlsVisibility(window, 'visible');}catch(e){}
        setWindowedControlsVisibility(window,'hidden');
    }

    function CloseMailDetailDiv()
    {   
        var DivFram = document.getElementById('DivIFrame')        
        document.getElementById('divDisable').style.width = 0;
        document.getElementById('divDisable').style.height = 0;
        IFMailDetail.location='blank.aspx';
        DivFram.style.display= "none";
        document.getElementById('divDisable').style.display = 'none';
        try{setWindowedControlsVisibility(window, 'visible');}catch(e){}
    }

</script>