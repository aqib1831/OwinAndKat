<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="UMv3_Default" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>User Manual</title>
 <link href="css/print.css" media="print"  rel="stylesheet" type="text/css" />
 <link href="css/style.css" rel="stylesheet" type="text/css" />
 <script src="../scripts/jquery.js" type="text/javascript"></script> 
 <script src="js/main.js" type="text/javascript"></script>
 <script src="js/plugins/highlightRegex.js" type="text/javascript"></script>
 <script src="js/plugins/jquery.scrollTo.js" type="text/javascript"></script>
</head>
<body style="background-color:#333333;" >
    <form id="form1" runat="server">
    <asp:HiddenField ID="hdnType" runat="server" />
     <asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="300">
        </asp:ScriptManager>
   <div class="divMasterMain"> 
     <div align="center" class="divMasterHeaderouter"> 
        <div class="Header">
            <div class="Logo"></div>
            <div class="Menu">
                <ul>
                    <li><div class="Menu-icon-Back"></div></li>
                    <li><div class="Menu-icon-Next"></div></li>
                    <li><div class="Menu-icon-Home"></div></li>
                    <li><div class="Menu-icon-Print"></div></li>
                </ul>
            </div>
         </div>
      </div>
       <div align="center" class="divSubMasterPageouter">
          <table class="divSubMasterPageinner" align="center" border="0">
          <tr>
          <td >
          </td>
          <td class="centerColumn" style="width: 100%;">
           <div  class="pagetop"></div>
            <div id="dvcontentpages" class="dvcontentpages">
              <div class="pageHeader">
                <div class="divTitle">User Manual<span class="OpenTopic" onmousemove="this.className='OpenTopicMouseOverClass';" onmouseout="this.className='OpenTopic';"> </span></div>
                <div class="divSearchBox">
                  <div class="lefthedr"> 
                    <div class="post-search">
                        <div id="arrows" class="arrowSearch"> <span id="moveBack" class="moveBack"><img src="images/scrollUP.png" alt="Back" /></span><span id="moveNext" class="moveNext"><img src="images/scrollDOWN.png" alt="Next" /></span></div>
                         <span class="spnSearch"><div class="imgSearch">
                            </div>
                        </span>
                        <span class="spntxtSearch">
                             <input type="text" id="txtSearchPost" tabindex="1" maxlength="30" value="Search...."  />
                        </span>
                        <div id="clear" class="clearSearch" >0 of 0</div>   
                    </div>
                    <div class="btnSearch">
                        <span>&nbsp;</span> 
                        <div class="loadingSearch" style="display:none;"></div>                              
                    </div>
                </div>
               </div>
              </div>
               <div  class="PageHeaderLine"></div>
               <div id="divContent"  class="PageContent">
                <div id="tblModuleList" class="tblModuleList" > 
                        <asp:Repeater ID="rptClientManual" runat="server">
                                <ItemTemplate>
                                 <div class="trModuleList" >
                                    <div class="ModuleRow" id='<%#Eval("CategoryID")%>'><span class="Title" onmousemove="this.className='MouseOverClass';" onmouseout="this.className='Title';"><%#Eval("Title")%></span></div>
                                </div>
                                </ItemTemplate>
                                <FooterTemplate>
                                 <div class="Liner" ></div>
                                </FooterTemplate>
                        </asp:Repeater>
                 </div> 
                 <div id="tblTopicsList" class="tblTopicsList"></div> 
                 <div id="tblTopicDetail" class="tblTopicDetail">
                 </div> 

               </div>
            </div>
             <div class="pagebottom"></div>
             </td>
              <td >
             </td>
          </tr>
          </table>
       </div>
     </div>
    </form>
</body>
</html>