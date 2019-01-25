<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ViewStatus.aspx.vb" Inherits="NSBS_ViewStatus" Theme="Default" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>NSBS Status Information for Store</title>
    <link href="../../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="JavaScript" src="../../scripts/calendar.js"> </script>
    <script type="text/javascript" language="JavaScript" src="../../scripts/calendar-en.js"> </script>
    <script type="text/javascript" language="JavaScript" src="../../scripts/calendar-fs.js"> </script>
    <style type="text/css">
        .failed td {background-color:#F9DDD9; }
    </style>
</head>
<body  style="margin:0px;padding:0px;">
    <form id="form1" runat="server">
   <div id="divDisable" class="modalBackground" style="height:100%; width:100%; display:none;">
</div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <asp:UpdateProgress ID="uProgIdeaNotes" runat="server">
        <ProgressTemplate>        
        <div class="ProgressIndicatorDivGray">                            
            <br />
            <img src="../../images/indicator.gif" align="absmiddle" /><b>&nbsp;&nbsp;Loading ...</b>
            <br /><br />
        </div>
     </ProgressTemplate>
    </asp:UpdateProgress>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="height:100%;" >
    
  <tr class="GalleryTitle" style="background-image:url('../../images/bg_mainHdr_1.jpg');height:31px;">
    <td>&nbsp;<span class="IdeaTitle">NSBS Status Information ( 
    <asp:UpdatePanel ID="upFranchiseID" runat="server" RenderMode="Inline">
        <ContentTemplate>
            <asp:Literal ID="ltrFranchiseID" runat="server" Text="0"></asp:Literal>
        </ContentTemplate>
    </asp:UpdatePanel>)</span></td>
    <td  style="padding-right:5px; padding-top:2px;" align="right">
        &nbsp;
    </td>
  </tr>
  
  <tr  style="height:50px;">
    <td valign="middle" colspan="2" class="filter" >
        
    	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="height:100%;" >
            <tr>
                <td style="width: 110px; padding-left:5px;" align="left" id="td1">
                    From:<br />
                    <asp:TextBox CssClass="SmallBlueTextBox" ID="txtFromDate" runat="server" Width="70" ></asp:TextBox>
                    <img style="cursor: pointer" onclick="setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtFromDate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                        height="20" src="../../images/ico_calendar.jpg" width="24" align="absMiddle"
                        alt="" />&nbsp;
                </td>
                <td style="padding-right: 5px; width:10px;">
                    <div class="straightline">
                    </div>
                </td>
                <td style="width: 110px;" align="left">
                    To:<br />
                    <asp:TextBox CssClass="SmallBlueTextBox" ID="txtToDate" runat="server" Width="70"></asp:TextBox>
                    <img style="cursor: pointer" onclick="setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtToDate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                        height="20" src="../../images/ico_calendar.jpg" width="24" align="absMiddle"
                        alt="" />&nbsp;
                    
                </td>
                <td style="width: 30px; padding-top:15px;" valign="middle">
                    <asp:ImageButton ID="imgbtnSearch" ValidationGroup="date"  runat="server" ImageUrl="~/images/btn_go.gif"/>
                </td>
                <td style="padding-right: 5px; width:10px;">
                    <div class="straightline">
                    </div>
                </td>
                <td align="left" style="width: 140px;">
                    Show:<br />
                    <asp:DropDownList ID="ddlShow" SkinID="SmallTextCombo"  runat="server" Width="120px"
                        AutoPostBack="true">
                        <asp:ListItem Text="All" Value="2" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Successfull" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Unsuccessfull" Value="0"></asp:ListItem>
                       
                    </asp:DropDownList>
                </td>
                <td align="left" style="width: 140px; display:none;">
                    Select Software:<br />
                    <asp:DropDownList ID="ddlSoftwareType" SkinID="SmallTextCombo"  runat="server" Width="120px"
                        AutoPostBack="true">
                        <asp:ListItem Text="All" Value="0" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="EAI" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Frutation" Value="2"></asp:ListItem>
                        <asp:ListItem Text="SCR" Value="3"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td valign="middle">
                &nbsp;<br />
                <asp:CustomValidator ID="cvDate" runat="server" Display="dynamic" ErrorMessage="Date difference must be within 30 days."
                        ClientValidationFunction="dateValidation" ValidationGroup="date"  ></asp:CustomValidator>&nbsp;</td>
            </tr>
        </table>
     
    </td>
  </tr>
  <tr style="height:100%;">
    <td valign="top" colspan="2">
    <div id="divScroll" style="height:100%; width:100%; overflow-y:auto; " class="GrayScrollBar">    
    <asp:UpdatePanel ID="upKeys" runat="server" UpdateMode="Conditional">        
    <ContentTemplate>    
        <asp:GridView ID="gvwKeys" runat="server" AutoGenerateColumns="False" Width="100%"  SkinID="gvwSilverWithNoPaging"
            AllowPaging="false" AllowSorting="false" Height="100%" ShowFooter="true"
            EnableViewState="false">
            <Columns>
                 <asp:TemplateField HeaderText="Status">
                    <ItemTemplate> 
                 
                         <asp:Image id="imgStatus" runat="server"/>
                    </ItemTemplate>                   
                    <ItemStyle Width="5%" HorizontalAlign="Center" />                   
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Software" >
                    <ItemTemplate>
                       <span title='<%# Eval("DB") %>'><%# Eval("DB") %></span>
                    </ItemTemplate>
                    <FooterTemplate>
                        &nbsp;
                    </FooterTemplate>
                    <HeaderStyle Width="5%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Size MB">
                    <ItemTemplate>
                       <%#FormatNumber(((ctype (Functions.IfNull(Eval("ByteSize"),0),Decimal) / 1024) / 1024))%> MB
                    </ItemTemplate>
                    <FooterTemplate>
                        &nbsp;
                    </FooterTemplate>
                    <HeaderStyle Width="12%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Description">
                    <ItemTemplate>
                       <span title='<%# Eval("Description") %>'><%#Eval("Description")%></span>
                    </ItemTemplate>
                    
                    <HeaderStyle Width="46%" />
                </asp:TemplateField>                
                <asp:TemplateField HeaderText="Reported On">
                    <ItemTemplate>
                       <span><%#CType(Functions.IfNull(Eval("ReportedOn"), Date.Now), DateTime).ToString("F")%> (EST)</span>
                    </ItemTemplate>
                    
                    <HeaderStyle Width="30%" />
                </asp:TemplateField>                
                
            </Columns>
            <EmptyDataTemplate>                
                 <table class="NoRecord">
                    <tr>                            
                        <td>
                            <img align="absmiddle" src="../../images/ico_alert.gif" />&nbsp;&nbsp;No Backup Found !
                        </td>
                    </tr>
                 </table>                
            </EmptyDataTemplate>            
            <PagerSettings Mode="NextPreviousFirstLast" Visible="true" Position="Bottom" />
            <PagerTemplate>
                <table id="tblPager" width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>                        
                       <td style="border:0; width:85%;">Showing Licenses <asp:Literal ID="ltrlStartCount" runat="server" Text="0"></asp:Literal> to <asp:Literal ID="ltrlEndCount" runat="server" Text="0"></asp:Literal> of <asp:Literal ID="ltrlTotalCount" runat="server" Text="0"></asp:Literal></td> 
                       <td style="border:0;" align="right" nowrap="nowrap">Page&nbsp;<asp:Literal ID="ltrlStartPage" runat="server" Text="0"></asp:Literal> of <asp:Literal ID="ltrlLastPage" runat="server" Text="0"></asp:Literal>&nbsp;&nbsp;&nbsp;<asp:LinkButton ID="lnkBtnFirst" runat="server" CommandName="page" CommandArgument="first"><asp:Image ID="imgFirst" runat="server" ImageUrl="../images/First_blk.jpg" ToolTip="First" /></asp:LinkButton>&nbsp;<asp:LinkButton ID="lnkBtnPrevious" runat="server" CommandName="page" CommandArgument="prev"><asp:Image ID="imgPrevious" runat="server" ImageUrl="../images/back_blk.jpg" ToolTip="Previous" /></asp:LinkButton> &nbsp;<asp:LinkButton ID="lnkBtnNext" runat="server" CommandName="page" CommandArgument="next"><asp:Image ID="imgNext" runat="server" ImageUrl="../images/Next_blk.jpg"  ToolTip="Next" /></asp:LinkButton>&nbsp;<asp:LinkButton ID="lnkBtnLast" runat="server" CommandName="page" CommandArgument="last"><asp:Image ID="imgLast" runat="server" ImageUrl="../images/Last_blk.jpg" ToolTip="Last" /></asp:LinkButton>&nbsp;&nbsp;&nbsp;</td>
                    </tr>
                </table>
            </PagerTemplate>                       
        </asp:GridView>     
    </ContentTemplate>                           
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="ddlShow" EventName="SelectedIndexChanged" />        
        <asp:AsyncPostBackTrigger ControlID="imgbtnSearch" EventName="Click" />                                
        <asp:AsyncPostBackTrigger ControlID="ddlSoftwareType" EventName="SelectedIndexChanged" />        
    </Triggers>
    </asp:UpdatePanel>        
    </div>
    </td>
  </tr>  
  <tr id="trPager" > 
    <td id="tdPager" colspan="2">     
    </td>
  </tr>  
</table>

    <script language="javascript" type="text/javascript">
    
 function CloseValidationSummaryDiv(){            
            var ValidationSummary = document.getElementById('vsDate')
            ValidationSummary.style.display = 'none';
            document.getElementById('divDisable').style.display = 'none';
            
        }
    function dateValidation(sender,args)
    {

        var startDate = document.getElementById("<%= txtFromDate.ClientID %>").value;
        var endDate = document.getElementById("<%= txtToDate.ClientID %>").value;
     
        var one_day=1000*60*60*24; 

        var x = startDate.split("/");     
        var y = endDate.split("/");

        var date1=new Date(x[2],(x[0]-1),x[1]);
        var date2=new Date(y[2],(y[0]-1),y[1])
      
        
        var difference = Math.ceil((date2.getTime()-date1.getTime())/(one_day)); 
       if (difference > 30)
       {
            args.IsValid= false;            
       }
       else
            args.IsValid= true;
            
            
    }
    
ajustIcon();
function ajustIcon()
{
    var img = document.getElementById("imgAlert");
    if (img == null) return;
    img.src = "../../images/ico_alert.gif"
}                 
        function ChangeRowsClass(){
            var element = getElementByClassName('gvwSilverFooter');
            if(element!=null){
                element.className='gvwSilverFooterOdd';
            }
        } 
        
        function SetRowStyle(){
            var element = getElementByClassName('gvwSilverFooterOdd');
            if(element!=null){
                element.className='gvwSilverFooter';
            }           
        }
        
        AdjustPagerRow();
        
        function AdjustPagerRow(){                          
            var objTag = null;
            var objCustomRow = null;
            try{
            trPager.style.display='inline';
            objCustomRow = getElement("tdPager");
            objTag = getElementByClassName("gvwSilverPager");
            objCustomRow.innerHTML ='&nbsp;';
            if (objTag != null && objCustomRow != null)
            {        
                var objPagerHTML = getElement('tblPager').outerHTML;
                objCustomRow.innerHTML = objPagerHTML;
                objCustomRow.className = "cpygvwSilverPager";
                objTag.style.display = 'none';
            }
            else
            {
                //if the pager has not been displayed hide the row.
                trPager.style.display='none';
            }
            }catch(ex){
                //alert("Javascript Error:\n"+ex.description);
            }            
        }    
        var postbackElement;
        Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(beginRequest);
        Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(pageLoaded);
        Sys.WebForms.PageRequestManager.getInstance().add_pageLoading(onPageLoading);
        
        function beginRequest(sender, args) {
            postbackElement = args.get_postBackElement();
            
        }
        
        function pageLoaded(sender, args) {
            var updatedPanels = args.get_panelsUpdated();
            if (typeof(postbackElement) === "undefined") {
                return;
            } 
            for (i=0; i < updatedPanels.length; i++){
                if (updatedPanels[i].id == '<%= upKeys.ClientID %>') {                                     
                    AdjustPagerRow(); 
                    ajustIcon();
                }
            }
        }
        function onPageLoading(sender, e) {
        }      
    </script>
    </form>
</body>
</html>

