<%@ Page Language="VB" AutoEventWireup="false" CodeFile="RecentCreatedTopics.aspx.vb"
    Inherits="KB_RecentCreatedTopics" Theme="Default" EnableTheming="true" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Recent Topics</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <link href="../App_Themes/Default/Calendar/style.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>

    <script type="text/javascript">
function NewsDetail(id,type){
            if(type == 1)
            window.location="Topic_detail.aspx?TopicID="+id
        }
function onSearchClick(){
    var inputstr=document.getElementById('txtSearch').value;
    parent.OnSearchfromRecentTopics(inputstr);
    document.getElementById('txtSearch').value="";
}
    </script>

    <style type="text/css">

.HelpBackGround
{
background-image:url(../images/ico_help_fullpage.jpg);
background-position:right bottom;
background-repeat:no-repeat;
}

</style>
</head>
<body style="background-color: #E4F1F7; width: 100%; height: 100%; padding: 0px;
    margin: 0px;">
    <form id="form1" runat="server">
        <div>
            <table height="100%" width="100%" border="0" align="center" cellpadding="0" cellspacing="0"
                class="HelpBackGround">
                <tr class="UnderlinedRow">
                    <td style="padding-right: 5px; font-weight: bold; font-size: 15px; padding-bottom: 2px;
                        border-bottom: #609bd3 1px solid; background-color: #a0cdee; cursor: default;
                        height: 31px;" valign="middle">
                        &nbsp;
                        <img src="../images/ico_opsmanual_updates.gif" align="absmiddle">
                        Recently Added Topics
                    </td>
                    <td style="padding-right: 5px; font-weight: bold; font-size: 15px; padding-bottom: 2px;
                        border-bottom: #609bd3 1px solid; background-color: #a0cdee; cursor: default;
                        height: 31px;" align="right">
                        <asp:LinkButton ID="lnkAddTopic" runat="server" Visible="True">
                            <div style="width:150px;display:inline;" class="ManageButtonBlue">Manage Categories</div>
                        </asp:LinkButton>
                    </td>
                </tr>
                <tr>
                      <td style="padding:3px; white-space:nowrap;background-color:#BADCFC;height:31px;border-bottom:solid 1px #609BD3;" align="left"  colspan="2"   >
                          <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch"  >
                               <span class="GreyTextSmall">Search</span><br />
                                <span><asp:TextBox ID="txtSearch" runat="server" onfocus="javascript:this.value='';" MaxLength="50"   Width="179px"  onKeyPress="if(event.keyCode==13){onSearchClick(); return false;}"  SkinID="GreenSmallTextbox" />
                                <asp:ImageButton ID="btnSearch"  runat="server" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" OnClientClick="onSearchClick(); return false;" />
                                </span></asp:Panel>
                          </td>
                    
                </tr>
                <tr>
                    <td colspan="2" valign="top" align="center" style="padding: 40px; padding-top: 20px;padding-right:10px;">
                        <asp:Repeater ID="rptRemoteNews" runat="server" DataSourceID="SdTopics">
                            <HeaderTemplate>
                                <div style="overflow: auto; height: 100%;" class="ScrollBarHomeTicket">
                                    <table style="height: 100%; width: 100%; font-size: 11px;" cellpadding="0" cellspacing="0"
                                        border="0">
                                      
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr onmouseover="this.className='HighlightedRightPanelRow';" onmouseout="this.className='SimpeRightPanelRow';"
                                    class="SimpeRightPanelRow" title="Click to View Topic Detail">
                                    <td style="width: 20px; height: 25px; text-align: center; padding-left: 15px;">
                                        <img alt="" src='../images/ico_help_sml2.jpg' align="absmiddle" />
                                    </td>
                                    <td style="padding-left: 15px; cursor: pointer; font-size: 11px; font-family: Verdana;
                                        font-weight: bold;" title="<%#Container.DataItem("Name")%>" onclick="NewsDetail('<%# Container.DataItem("ID") %>',1);">
                                        <%#Functions.StringTruncate(Container.DataItem("Name"), 100)%>
                                    </td>
                                    <td align="left" style="padding-left: 15px; cursor:default; font-size: 12px; font-family: Verdana;"
                                        title="Click to View Topic">
                                        <%#Convert.ToDateTime(Container.DataItem("CreatedDate")).ToLongDateString()%>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                <tr>
                                    <td colspan="2">
                                    </td>
                                </tr>
                                </table> </div>
                            </FooterTemplate>
                        </asp:Repeater>
                    </td>
                </tr>
                <tr>
                    <td style="background-color: #BADCFC; height: 10px;" colspan="2">
                        <asp:SqlDataSource ID="SdTopics" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                            SelectCommand="KB_Get_RecentCreatedTopics" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
