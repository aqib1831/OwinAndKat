<%@ Page Language="VB" AutoEventWireup="false" CodeFile="FranInbox_Detail.aspx.vb" Inherits="FranMail_FranInbox_Detail" %>


<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Franmail Detail</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
      <link href="../App_Themes/Default/Calendar/style.css" rel="stylesheet" type="text/css" />
    <link href="../FranMail/style/Style.css" rel="stylesheet" type="text/css" />
</head>
<body style="margin:0px;width:100%;height:100%;" onload="changeCaption();">
 <form id="form1" runat="server" >
     <asp:HiddenField ID="hdnMailID" runat="server" />
     <asp:HiddenField ID="hdnMailBox" runat="server" />
    <div id="divDisable" class="modalBackground" ></div>
    <div>
     <asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="300" ></asp:ScriptManager>
      <asp:UpdateProgress ID="Progress1" runat="server">
            <ProgressTemplate>
                <div class="ProgressIndicatorDIV" >
                    <br />
                    <asp:Image ID="Image2" runat="server" ImageUrl="~/images/indicator.gif" ImageAlign="AbsMiddle" /> <span style="color:#4B92C1;font-size:14px;"><b>&nbsp;&nbsp;Loading ...</b></span>
                    <br /><br />
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
      <table style="width:100%;height:100%;" border="0" cellspacing="0" cellpadding="0"  class="MainTable">
          <tr>
             <td > 
                <table   style="width:100%;height:100%;background-color:#FFFFFF; " class="Table"   border="0" align="center" cellpadding="0" cellspacing="0" > 
                     <tr>
                       <td style="height:85px;">      
                              <table style="width:100%;height:25%; border-color:#7391B9;"  border="0" align="center" cellpadding="0" cellspacing="0" class="Table"  >
                               <tr style="background-color:#DDE4EE;">
                                    <td style="height:31px;" colspan="7">	
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                               <td class="SimpleBold" style="height:31px;background-color:#BDE7BD;color:#000000;border-bottom:1 solid #609BD3; width:80%; ">
                                                &nbsp;<strong style="font-size:15px; "><asp:Label ID="lblTitle" runat="server" ></asp:Label></strong>  &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;                                                                                                     
                                                </td>                                                
                                                <td colspan="2" style="padding-right: 3px; padding-left: 3px; font-weight: bold;
                                                    font-size: 12px; padding-bottom: 3px; cursor: pointer; color: #437494; padding-top: 3px;
                                                    border-bottom: #609bd3 1px solid; height: 1px; background-color: #bde7bd; text-align: right" align="center">&nbsp;
                                                    <%--<table border="0" cellpadding="0" cellspacing="0" style="width: 120px; background-color: #bde7bd"  >
                                                        <tr>
                                                            <td style="height:30px; width:57px; padding-right: 3px;" valign="middle">
                                                                <img src="Images/reply.jpg" onclick="javascript:window.location='Compose.aspx?ID=<%=hdnMailID.Value %>&Action=Reply&Mailbox=<%=hdnMailbox.value %>&From=<%=Request.QueryString("From")%>'" onmouseover="this.style.cursor='hand';"/> 
                                                            </td>
                                                            <td style="width:5px; height: 30px;" align="center" >|</td>
                                                            <td style="height:30px; width:70px; padding-left: 3px;" valign="middle">
                                                               <img src="Images/forward.jpg" onclick="javascript:window.location='Compose.aspx?ID=<%=hdnMailID.Value %>&Action=Forward&Mailbox=<%=hdnMailbox.value %>&From=<%=Request.QueryString("From")%>'" onmouseover="this.style.cursor='hand';"/>    
                                                            </td>
                                                        </tr>
                                                    </table>--%>
                                                    </td>
                                            </tr>
                                       </table>
                                    </td>
                                </tr> 
                                <tr style="border-color:#F5F5F5; background-color:#DEF7D6;">
                                    <td style="width:1%;height:20px;"></td>
                                    <td style="width:3%; height: 20px;" class="SimpleExSmall">
                                        Subject:</td>
                                    <td class="SimpleExSmall" style="width: 3%; height: 20px">
                                    </td>
                                    <td colspan="4" style="height: 20px">
                                    <strong><asp:Label runat="server" ID="lblSubject" /></strong></td>
                                </tr>                    
                                <tr > 
                                    <td height="1"  colspan="6"><img  src="../images/spacer.gif" width="1" height="1" alt="" /></td>
                                </tr>
                                <tr style="border-color:#F5F5F5; background-color:#DEF7D6;" valign="middle">
                                    <td ></td>
                                    <td  style="height:20px;" class="SimpleExSmall"> From: </td>
                                    <td class="SimpleExSmall" style="height: 20px">
                                    </td>
                                    <td>                            
                                       <strong><asp:Label runat="server" ID="lblFrom" /> </strong>
                                    </td>
                                    <td ></td>
                                    
                                    <td  class="SimpleExSmall" style="width: 3%">
                                        <%--To:--%></td>
                                    <td >
                                        <strong><asp:Label runat="server" ID="lblTo" /></strong></td>                                                            
                                </tr>
                                 <tr > 
                                    <td height="1"  colspan="6"><img  src="../images/spacer.gif" width="1" height="1" alt="" /></td>
                                 </tr>
                                  <tr style="border-left-color: #f5f5f5; border-bottom-color: #f5f5f5; border-top-color: #f5f5f5;
                                      background-color: #def7d6; border-right-color: #f5f5f5" valign="middle">
                                      <td>
                                      </td>
                                      <td class="SimpleExSmall" style="height: 20px">
                                          Date:</td>
                                      <td class="SimpleExSmall" style="height: 20px">
                                      </td>
                                      <td>
                                      <strong><asp:Label runat="server" ID="lblDate" /></strong></td>
                                      <td>
                                      </td>
                                      <td class="SimpleExSmall">
                                          Size:</td>
                                      <td>
                                         <strong > <asp:Label ID="lblSize" runat="server"></asp:Label></strong></td>
                                  </tr>
                                  <tr > 
                                    <td height="1"  colspan="6"><img  src="../images/spacer.gif" width="1" height="1" alt="" /></td>
                                </tr>
                                <tr id="trAttachments" runat="server"  style="border-color:#F5F5F5; background-color:#DEF7D6;" valign="middle">
                                    <td ></td>
                                    <td  style="height:20px;" class="SimpleExSmall"> Attachments: </td>
                                    <td class="SimpleExSmall" style="height: 20px">
                                    </td>
                                    <td colspan="4" >   
                                    <div style="overflow:auto; height:100%; width:100%; ">
                                       <strong><asp:Literal ID="ltlFileNames" runat="server"></asp:Literal></strong>
                                    </div>                         
                                    </td>
                                </tr>
                            </table>                                                                          
                      </td>
                    </tr>
                     <tr>
                       <td style="width: 100%;height:100%;">  
                          <div style="width: 100%;height:100%;vertical-align:top;"  class="DivScroll" >  
                             <table style="width: 100%;height:100%;" cellpadding="0" cellspacing="0" border="0"> 
                                <tr>
                                    <td style="padding:0px;" valign="top" >
                                       <table style="width:100%; height:100%; vertical-align:top;"   border="0"  cellpadding="0" cellspacing="0" >
                                           <tr>
                                               <td style="width:100%; height:100%; vertical-align:top; " >
                                                   <div style="overflow:auto; height:100%; width:100%; padding-left:5px; padding-bottom:5px; " id="Div1" class="SimpleLabel">
                                                        <asp:Label ID="lblEmailBody" runat="server" Width="100%"></asp:Label>
                                                   </div>
                                              </td>
                                           </tr>
                                       </table> 
                                    </td>
                                </tr>
                            </table>  
                         </div>            
                      </td>
                    </tr>          
                     <tr style="background-color:#BDE7BD;">
                         <td style="border-top:1 solid #609BD3; padding:3px;" align ="center"  > 
                             <input id="btnBack" type="button" value="Close" onclick="parent.CloseMailDetailDiv();" class="Btn3D"  />&nbsp;</td><%--"window.location='Inbox.aspx?MailBox=<%=hdnMailBox.value %>'"--%>
                    </tr>      
               </table>
           </td>
         </tr>
       </table>
    </div>
 </form>
</body>
</html>
<script language="javascript" type="text/javascript" >
function ChangeStyle(element)
{
    element.style.backgroundColor = "#DEF7D6";
}
function ChangeStyle1(element)
{
    element.style.backgroundColor = "#AAFFAA";
}
function Close(){
    if('<%=Request.QueryString("From")%>'=='Inbox')
    {
        parent.ReportsDiv.style.display = "none";
        parent.ReportsDiv.style.width ="0%";
        parent.ReportsDiv.style.height ="0%"; 
        parent.iframeEmail.location.href ="blank.aspx" ;
    }
    else if('<%=Request.QueryString("From")%>'=='')
    {
        window.location = 'Inbox.aspx?Mailbox=<%=Request.QueryString("Mailbox")%>';
    }
    else
    {
        parent.ReportsDiv.style.display = "none";
        parent.ReportsDiv.style.width ="0%";
        parent.ReportsDiv.style.height ="0%"; 
        parent.iframeEmailMain.location.href ="blank.aspx" ;
    }
}
function changeCaption()
{
    if ('<%=Request.QueryString("From")%>'=='LeftPanel')
    {
        document.getElementById("btnBack").value = "Close"; 
    }
}
</script> 
