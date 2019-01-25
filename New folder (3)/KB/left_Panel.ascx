<%@ Control Language="VB" AutoEventWireup="false" CodeFile="left_Panel.ascx.vb" Inherits="KB_left_Panel" %>
<div id="DivSearchIFrame" runat="server" style="display: none; border: solid 1px #000000;
    position: absolute; width: 300px; height: 87%; top: 13%; left: 3px; z-index: 101;">
    <div id="SearchLoadingProgress" style="position: absolute; width: 150px; height: 50px;
        left: 10%; top: 45%;" class="MessageDiv">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height: 100%">
            <tr>
                <td style="width: 5%;">
                    &nbsp;
                </td>
                <td align="right" valign="middle" style="width: 25%;">
                    <div style="text-align: right;">
                        <asp:Image ID="Img" runat="server" ImageUrl="../images/indicator.gif" ImageAlign="AbsMiddle" />&nbsp;&nbsp;
                    </div>
                </td>
                <td nowrap="nowrap" align="left" valign="middle" id="divMessage" style="width: 75%;
                    color: #4B92C1;">
                    <b>&nbsp;&nbsp;Loading ...</b></td>
            </tr>
        </table>
    </div>
    <table width="100%" style="height: 100%;" cellpadding="0" border="0" cellspacing="0">
        <tr>
            <td align="left" style="border-bottom: solid 1px #000000; padding-left: 0.5em; background-image: url(../images/bg_CellNormal_black.jpg);
                background-repeat: repeat-x; width: 100%; height: 28px; cursor: default;">
                <strong>
                    <label id="lblSearchTitle" title="" style="color: White;">
                    </label>
                </strong>
            </td>
            <td valign="middle" style="border-bottom: solid 1px #000000; background-image: url(../images/bg_CellNormal_black.jpg);
                background-repeat: repeat-x; width: 100%; height: 28px; cursor: pointer;">
                <img src="../images/win_btn_close_black.jpg" style="float: right;" alt="Close window"
                    onclick="ResetSearch()" />
            </td>
        </tr>
        <tr valign="top">
            <td colspan="2" style="width: 100%; height: 100%; margin: 0px;" valign="top">
                <iframe frameborder="0" src="blank.aspx" style="width: 100%; height: 100%; border: 0px"
                    scrolling="no" id="framsearchpopup"></iframe>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center" style="padding: 2px; background-color: #E4F1F7; z-index: 101;">
                <div style="width: 60px; display: inline;" class="FlatButton" onclick="ResetSearch();">
                    Close</div>
            </td>
        </tr>
    </table>
</div>
<div style="display: block; width: 100%; height: 100%;" id="dvleftPanel">
    <table border="0" cellpadding="0" cellspacing="0" style="border: solid 0px #EEEDE5;height: 100%; width:250px;" bgcolor="#D8EAFC">        
        <tr class="HeaderRow">
            <td colspan="3" style="padding-right: 5px; font-weight: bold; font-size: 15px; padding-bottom: 0px;
                border-bottom: #609bd3 1px solid; height: 31px; background-color: #a0cdee; cursor: default;"
                valign="middle">
                <span class="DarkBluelabel">&nbsp;Knowledge Base</span></td>
        </tr>
        <tr>
            <td colspan="3" style="padding-right: 5px; font-weight: bold; font-size: 15px; padding-bottom: 4px;
                border-bottom: #609bd3 1px solid; height: 31px; background-color: #BADCFC; padding-left: 2px;"
                valign="top">
                <asp:UpdatePanel ID="UPSearch" runat="server">
                    <ContentTemplate>
                        <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" CssClass="GreyTextSmall">
                            Search:
                            <br />
                            <asp:TextBox ID="txtSearch" runat="server" AutoPostBack="false" Width="220px" MaxLength="30"
                                CssClass="SmallGreenTextBox" onKeyPress="if(event.keyCode==13){onSearchClick(); return false;}"
                                onfocus="this.value='';"></asp:TextBox>
                            <asp:ImageButton ID="btnSearch" runat="server" CausesValidation="false" OnClientClick="onSearchClick(); return false;"
                                ImageUrl="../images/ico_bullet.gif" />
                        </asp:Panel>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr runat="server" id="tr_One" class="Calendar_Selected">
            <td align="center" style="width:25px;">
                <div runat="server" id="img_one" style="height:31px; width:20px; display: inline;" align="absmiddle"  />
            </td>
            <td colspan="2" style="width:100%;" align="left">
                &nbsp;&nbsp;Pick a Category
            </td>
        </tr>   
        <tr>
        <td style="height:100%; width:100%;" colspan="3">
        <div id="dvChapter" style="vertical-align: top; width:100%; height:100%; overflow-y: auto;" runat="server" class="ScrollBarHomeTicket">                                
                <asp:Repeater ID="RepCategorylst" runat="server" DataSourceID="SdsCategories">                                                                                 
                    <ItemTemplate>
                        <div style="border-bottom: 2px inset #E5F1FB; padding-left:5px; padding-right:5px;cursor: pointer; height: 25px; text-align: left; font-size: 13px; padding-right: 2px;
                            padding-top: 3px;" title="<%#Container.DataItem("Name")%>"  onclick="parent.RedirectIframe('List_Topics.aspx?CategoryID=<%#Container.DataItem("ID")%>');">
                           &nbsp;&nbsp; - <%#Server.HtmlEncode(Functions.StringTruncate(Container.DataItem("Name"), 30))%>
                        </div>                        
                    </ItemTemplate>       
                </asp:Repeater>                    
                <asp:SqlDataSource ID="SdsCategories" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                    SelectCommand="KB_Get_Categories" SelectCommandType="StoredProcedure" >                    
                </asp:SqlDataSource>                                                                           
        </div>
        </td>
        </tr>
    </table>      
</div>

<script type="text/javascript">
   
 function RedirectIframe(url){
    var iframe = document.getElementById("IFrame");
    iframe.src=url;
    return false;
        }
function onSearchClick(){
    var inputStr;
    inputStr = document.getElementById('<%= txtSearch.ClientID %>').value;
    if (CheckNoisyWord(inputStr)==false){
        framsearchpopup.location ='SearchResult.aspx?Search='+inputStr.toString();
        lblSearchTitle.innerText = 'Found Topics';
        document.getElementById('<%= txtSearch.ClientID %>').value='';
        var trHeading=document.getElementById('<%= tr_One.ClientID %>')
        trHeading.style.display= 'none';
        var DivFram = document.getElementById('<%= DivSearchIFrame.ClientID %>'); 
        DivFram.style.display= 'block';
        SearchLoadingProgress.style.display='block';
        }else{
            return false;
        }
    }
         
function ResetSearch(){
    framsearchpopup.location ='blank.aspx';
    var DivFram = document.getElementById('<%= DivSearchIFrame.ClientID %>');
    var trHeading=document.getElementById('<%= tr_One.ClientID %>')
    trHeading.style.display= 'block';      
    DivFram.style.display= "none";
    document.getElementById('<%= txtSearch.ClientID %>').value='';
    document.getElementById('<%= btnSearch.ClientID %>').focus();
    SearchLoadingProgress.style.display='block';
    return false;
}
 function CheckNoisyWord(InputStr){
       if (isBlank(InputStr)==true)
        {document.getElementById('<%= txtSearch.ClientID %>').value='';
         return true;}
        if (CheckSpecailChar(InputStr)==true)
        { alert ("Special characters are not Allowed.");
        document.getElementById('<%= txtSearch.ClientID %>').value='';return true;}
        var x;
        var noisyWords = new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "$", "a", "about", "after", "all", "also", "an", "and", "another", "any", "are", "as", "at", "b", "be", "because", "been", "before", "being", "between", "both", "but", "by", "c", "came", "can", "come", "could", "d", "did", "do", "does", "e", "each", "else", "f", "for", "from", "g", "get", "got", "h", "had", "has", "have", "he", "her", "here", "him", "himself", "his", "how", "i", "if", "in", "into", "is", "it", "its", "j", "just", "k", "l", "like", "m", "make", "many", "me", "might", "more", "most", "much", "must", "my", "n", "never", "now", "o", "of", "on", "only", "or", "other", "our", "out", "over", "p", "q", "r", "re", "s", "said", "same", "see", "should", "since", "so", "some", "still", "such", "t", "take", "Test", "than", "that", "the", "their", "them", "then", "there", "these", "they", "this", "those", "through", "to", "too", "u", "under", "up", "use", "v", "very", "w", "want", "was", "way", "we", "well", "were", "what", "when", "where", "which", "while", "who", "will", "with", "would", "x", "y", "you", "your", "z","!","@","#","%","^","'","-","+","~",":",";","<",">","?","`","=","*","_",")","(","/","\/","[","]","|");
        for (x=0;x<=noisyWords.length-1;x++)
            {
              if(InputStr.toLowerCase()==noisyWords[x].toLowerCase())
             {
                alert("\"" + InputStr + "\""+" is not descriptive word!");
                document.getElementById('<%= txtSearch.ClientID %>').value='';
                document.getElementById('<%= txtSearch.ClientID %>').focus();
                return true;
              }
           }
           return false;
        }
        
function isBlank(val)
   {
	if(val==null){return true;}
	for(var i=0;i<val.length;i++) {
		if ((val.charAt(i)!=' ')&&(val.charAt(i)!="\t")&&(val.charAt(i)!="\n")&&(val.charAt(i)!="\r")){return false;}
	     }
	return true;
   	}
	
function CheckSpecailChar(val)
	{
	    var iChars = "!@#$%^&*()+=-_[]\\\';,./{}|\":<>?";
        for (var i = 0; i < val.length; i++) {
  	    if (iChars.indexOf(val.charAt(i)) != -1) {
  	    return true;}
  	       }
  	}
  	
  function RefreshMain(){
    window.location='Default.aspx?Change=1';
    }
    
    function OnSearchfromRecentTopics(inputStr){
    if (CheckNoisyWord(inputStr)==false){
        framsearchpopup.location ='SearchResult.aspx?Search='+inputStr.toString();
        lblSearchTitle.innerText = 'Found Topics';
        document.getElementById('<%= txtSearch.ClientID %>').value='';
        var DivFram = document.getElementById('<%= DivSearchIFrame.ClientID %>'); 
    
        DivFram.style.display= 'block';
        SearchLoadingProgress.style.display='block';
        }else{
            return false;
        }

    }
</script>

