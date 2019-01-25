<%@ Page Language="VB" AutoEventWireup="false" CodeFile="UpdateManagement.aspx.vb"
    Inherits="LM_UpdateManagement" Theme="Default" %>

    

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Update Management</title>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
</head>
<body style="margin: 0px; padding: 0px;">
    <form id="form1" runat="server">
    <%--<script language="javascript" type="text/javascript">
        function setValues(SExp) {
            document.getElementById('<%=hdnSortBy.ClientID %>').value = SExp;
        }
    </script>--%>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:HiddenField ID="hdnSortBy" runat="server" />
    <asp:HiddenField ID="hdnSearch" runat="server" />
    <asp:HiddenField ID="hdnUserID" runat="server" />
    <asp:HiddenField ID="hdnShowBtn" runat="server" />
    <asp:UpdateProgress ID="uProgIdeaNotes" runat="server">
        <ProgressTemplate>
            <div class="ProgressIndicatorDivGray">
                <br />
                <img src="../images/indicator.gif" align="absmiddle" /><b>&nbsp;&nbsp;Loading ...</b>
                <br />
                <br />
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="height: 100%;">
        <tr class="GalleryTitle" style="background-image: url('../images/bg_mainHdr_1.jpg');
            height: 31px;">
            <td>
                &nbsp;<span class="IdeaTitle">SMSx Live Update -
                    <asp:UpdatePanel ID="uppUpdateCount" runat="server" RenderMode="Inline">
                        <ContentTemplate>
                            <asp:Literal ID="ltrlRecordCount" runat="server" Text="0"></asp:Literal>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </span>
            </td>
        </tr>
        <tr style="height: 41px;">
            <td valign="middle" colspan="2">
                <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="height: 100%;"
                        class="gvwSearchSilver">
                        <tr>
                            <td style="padding-right: 5px;">
                                <div class="straightline">
                                </div>
                            </td>
                            <td style="width: 180px;">
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td>
                                            Country:&nbsp;
                                        </td>
                                        <td>
                                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always" RenderMode="Inline">
                                                <ContentTemplate>
                                                    <asp:DropDownList ID="ddlCountry" CssClass="DarkBlackTextSmall" runat="server" Width="120px"
                                                        AutoPostBack="true" EnableViewState="true">
                                                        <asp:ListItem Text="United States" Value="1" Selected="true" />
                                                        <asp:ListItem Text="Canada" Value="3" />
                                                    </asp:DropDownList>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="padding-right: 5px;">
                                <div class="straightline">
                                </div>
                            </td>
                            <td align="right">
                                <table cellpadding="0" cellspacing="0" border="0" style="width: 100px;">
                                    <tr>
                                        <td>
                                            Search:&nbsp;
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtSearch" runat="server" Style="height: 20px;" MaxLength="50"></asp:TextBox>&nbsp;
                                        </td>
                                        <td>
                                            <asp:Button ID="btnSearch" runat="server" Text="Go" CssClass="btnSilver" Width="37px" />&nbsp;&nbsp;&nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr style="height: 100%;">
            <td valign="top" colspan="2">
                <div id="divScroll" style="height: 100%; width: 100%; overflow-y: auto;" class="GrayScrollBar">
                    <asp:UpdatePanel ID="upKeys" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:GridView ID="gvwUpdates" runat="server" AutoGenerateColumns="False" Width="100%"
                                Height="100%" SkinID="gvwSilver" AllowSorting="true" AllowPaging="true" ShowFooter="true"
                                EnableViewState="true" >
                                <Columns>
                                    <asp:TemplateField HeaderText="Release Title" SortExpression="VersionNo">
                                        <ItemTemplate>
                                            <asp:HiddenField ID="hdnId" runat="server" Value='<%# Eval("ID")%>' />
                                            <%# Eval("VersionNo")%>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            &nbsp;
                                        </FooterTemplate>
                                        <HeaderStyle Width="90%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Update Available Date" SortExpression="UpdateAvailableDate">
                                        <ItemTemplate>
                                            <%# String.Format("{0:MMM dd, yyyy}", Eval("UpdateAvailableDate"))%>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            &nbsp;
                                        </FooterTemplate>
                                        <HeaderStyle Width="10%" />
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>
                                    <table class="NoRecord">
                                        <tr>
                                            <td>
                                                <img align="absmiddle" src="../../images/ico_alert.gif" />&nbsp;&nbsp;No Update
                                                Found !
                                            </td>
                                        </tr>
                                    </table>
                                </EmptyDataTemplate>
                                <PagerSettings Mode="NextPreviousFirstLast" Visible="true" Position="Bottom" />
                                <PagerTemplate>
                                    <table id="tblPager" width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td style="border: 0; width: 85%;">
                                                Showing Updates
                                                <asp:Literal ID="ltrlStartCount" runat="server" Text="0"></asp:Literal>
                                                to
                                                <asp:Literal ID="ltrlEndCount" runat="server" Text="0"></asp:Literal>
                                                of
                                                <asp:Literal ID="ltrlTotalCount" runat="server" Text="0"></asp:Literal>
                                            </td>
                                            <td style="border: 0;" align="right" nowrap="nowrap">
                                                Page&nbsp;<asp:Literal ID="ltrlStartPage" runat="server" Text="0"></asp:Literal>
                                                of
                                                <asp:Literal ID="ltrlLastPage" runat="server" Text="0"></asp:Literal>&nbsp;&nbsp;&nbsp;<asp:LinkButton
                                                    ID="lnkBtnFirst" runat="server" CommandName="page" CommandArgument="first">
                                                    <asp:Image ID="imgFirst" runat="server" ImageUrl="../images/First_blk.jpg" ToolTip="First" /></asp:LinkButton>&nbsp;<asp:LinkButton
                                                        ID="lnkBtnPrevious" runat="server" CommandName="page" CommandArgument="prev">
                                                        <asp:Image ID="imgPrevious" runat="server" ImageUrl="../images/back_blk.jpg" ToolTip="Previous" /></asp:LinkButton>
                                                &nbsp;<asp:LinkButton ID="lnkBtnNext" runat="server" CommandName="page" CommandArgument="next">
                                                    <asp:Image ID="imgNext" runat="server" ImageUrl="../images/Next_blk.jpg" ToolTip="Next" /></asp:LinkButton>&nbsp;<asp:LinkButton
                                                        ID="lnkBtnLast" runat="server" CommandName="page" CommandArgument="last">
                                                        <asp:Image ID="imgLast" runat="server" ImageUrl="../images/Last_blk.jpg" ToolTip="Last" /></asp:LinkButton>&nbsp;&nbsp;&nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                </PagerTemplate>
                            </asp:GridView>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddlCountry" EventName="SelectedIndexChanged" />
                            <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </td>
        </tr>
        <tr id="trPager">
            <td id="tdPager" colspan="2">
            </td>
        </tr>
    </table>
    <asp:Button ID="btnRebindGrid" runat="server" Text="Rebind Grid" Style="display: none" />
    <script language="javascript" type="text/javascript" src="../scripts/functions.js"></script>
    <script language="javascript" type="text/javascript">


        function ChangeRowsClass() {
            var element = getElementByClassName('gvwSilverFooter');
            if (element != null) {
                element.className = 'gvwSilverFooterOdd';
            }
        }

        function SetRowStyle() {
            var element = getElementByClassName('gvwSilverFooterOdd');
            if (element != null) {
                element.className = 'gvwSilverFooter';
            }
        }

        AdjustPagerRow();

        function AdjustPagerRow() {
            var objTag = null;
            var objCustomRow = null;
            try {
                trPager.style.display = 'inline';
                objCustomRow = getElement("tdPager");
                objTag = getElementByClassName("gvwSilverPager");
                objCustomRow.innerHTML = '&nbsp;';
                if (objTag != null && objCustomRow != null) {
                    var objPagerHTML = getElement('tblPager').outerHTML;
                    objCustomRow.innerHTML = objPagerHTML;
                    objCustomRow.className = "cpygvwSilverPager";
                    objTag.style.display = 'none';
                }
                else {
                    //if the pager has not been displayed hide the row.
                    trPager.style.display = 'none';
                }
            } catch (ex) {
                //alert("Javascript Error:\n"+ex.description);
            }
        }
        var postbackElement;
        Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(beginRequest);
        Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(pageLoaded);
        Sys.WebForms.PageRequestManager.getInstance().add_pageLoading(onPageLoading);

        function beginRequest(sender, args) {
            postbackElement = args.get_postBackElement();
            document.getElementById("<%=hdnSearch.ClientID%>").value = document.getElementById('<%= txtsearch.ClientID %>').value;
        }

        function pageLoaded(sender, args) {
            var updatedPanels = args.get_panelsUpdated();
            if (typeof (postbackElement) === "undefined") {
                return;
            }
            for (i = 0; i < updatedPanels.length; i++) {
                if (updatedPanels[i].id == '<%= upKeys.ClientID %>') {
                    AdjustPagerRow();
                    document.getElementById('<%= txtsearch.ClientID %>').value = '';
                }
            }
        }
        function onPageLoading(sender, e) {
        }

        function ShowUpdateGroups(updateID, VersionNo) {
            var ddlCountry = document.getElementById('<%= ddlCountry.ClientID %>').value;
            window.location = 'UpdateGroups.aspx?UpdateID=' + updateID + '&CountryID=' + ddlCountry + '&VersionNo=' + VersionNo;
        }

        
    </script>
    </form>
</body>
</html>