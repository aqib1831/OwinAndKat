<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SearchResult.aspx.vb" Inherits="KB_SearchResult" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <link href="../App_Themes/Default/Calendar/style.css" rel="stylesheet" type="text/css" />
    <title>Search Result</title>
     <script type="text/javascript">
   function HideLoading(){
     try {parent.document.getElementById('SearchLoadingProgress').style.display='none';}catch(e) {}
    }
    </script>
    <style type="text/css">
    .HightLight
    {
        background-color:#DAF5D6;
    }
    .HightLightBold
    {
        font-weight:bold;
        background-color:#DAF5D6;
    }
    .NormalText
    {
        font-weight:normal;
        background-color:#FFFFFF;
    }
    </style>
</head>
<body style="margin: 0px; padding: 0px; width: 100%; height: 100%; border: 0px; background-color: #E4F1F7;"
    onload="HideLoading()">
    <form id="form1" runat="server">
    
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:HiddenField runat="server" ID="hdnSearch" Value="" />
        <asp:UpdateProgress ID="Progress1" runat="server">
            <ProgressTemplate>
                <div id="ProgressBar" style="position: absolute; width: 200px; height: 50px; left: 2%;
                    top: 45%; display: block;" class="MessageDiv">
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height: 100%">
                        <tr>
                            <td style="width: 5%;">
                                &nbsp;</td>
                            <td align="right" valign="middle" style="width: 25%;">
                                <div style="text-align: right;">
                                    <asp:Image ID="Image2" runat="server" ImageUrl="../images/indicator.gif" ImageAlign="AbsMiddle" />&nbsp;&nbsp;
                                </div>
                            </td>
                            <td nowrap="nowrap" align="left" valign="middle" id="divMessage" style="width: 75%;
                                color: #4B92C1;">
                                <b>&nbsp;&nbsp;Loading ...</b></td>
                        </tr>
                    </table>
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
        <table style="height: 100%; width: 100%; border: 0px; margin: 0px; padding: 0px;"
            cellpadding="0" cellspacing="0">
            <tr>
                <td style="background-color: #BADCFC; height: 20px; font-size: 13px;">
                    &nbsp;
                    <asp:Label ID="lblMsg" runat="server" Text="0"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="background-color: White; margin: 0px; padding: 0px; height: 100%; padding-top: 3px;"
                    valign="top">
                    <div id="dvResult" style="overflow-y: auto; display: block; vertical-align: top;
                        height: 100%;padding:10px;" >
                        <asp:UpdatePanel ID="UPSearch" runat="server">
                            <ContentTemplate>
                                <table width="100%" style="text-align: left; background-color: White; margin: 0px;
                                    padding: 0px;" cellpadding="0" cellspacing="0">
                                    <asp:Repeater ID="RepSearchResult" runat="server" DataSourceID="dsSearch">
                                        <ItemTemplate>
                                            <tr style="border-bottom: 2px inset #E5F1FB;">
                                                <td class="GridArrowColumn" style="width: 10px;height:20px; border-bottom: 2px inset #E5F1FB;">
                                                &nbsp;
                                                </td>
                                                <td style=" text-align: left; font-size: 12px; padding-left: 0.5em; border-bottom: 2px inset #E5F1FB;cursor: pointer; height: 22px; padding-right: 0px;" 
                                                    onclick="parent.RedirectIframe('Topic_detail.aspx?TopicID=<%#Container.DataItem("ID")%>&Searchtxt=<%= Server.HtmlEncode(Request.Querystring("Search")).Replace("'","\'") %>' ); HightLight(this);"
                                                    onmouseover="onOver(this)"
                                                    onmouseout="onOut(this)"
                                                    title="<%#Container.DataItem("Name")%>" id="td_<%#Container.DataItem("ID")%>">
                                                  <%#Functions.StringTruncate(Container.DataItem("Name"), 50)%>
                                                </td>
                                                <td style="width: 5px;">
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="vertical-align: top; background-color: White;">
                    <asp:ObjectDataSource ID="dsSearch" runat="server" SelectMethod="SearchKnowledgeBase" TypeName="Topic">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="hdnSearch" DefaultValue="" Name="Search" PropertyName="Value"
                                Type="String" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
                </td>
            </tr>
        </table>
    </form>
<script type="text/javascript">
   var selTd = '';
    function onOver(td){
        if (td.className=='HightLightBold')
            return;
        td.className='HightLight';
    }
    function onOut(td){
        if (td.className=='HightLightBold')
            return;
        td.className='NormalText';
    }
    function HightLight(td){
   
        if (selTd !== '') document.getElementById(selTd).className='NormalText';
        selTd = td.id;
        td.className='HightLightBold';
    }
</script>
</body>
</html>