<%@ Page Language="VB" AutoEventWireup="false" CodeFile="UpdateGroups.aspx.vb" Inherits="LM_UpdateGroups"
    Theme="Default" %>
  

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Update Groups</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../jquery/scripts/jquery-1.11.1.min.js"></script>
</head>
<body onclick="CloseNewGroupDiv();" style="margin: 0px; padding: 0px;">
    <form id="form1" runat="server">     <script language="javascript" type="text/javascript">
         function setValues(SExp) {
             document.getElementById('<%=hdnSortBy.ClientID %>').value = SExp;
         }
    </script>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:HiddenField ID="hdnSortBy" runat="server" />
    <asp:HiddenField ID="hdnSearch" runat="server" />
    <asp:HiddenField ID="hdnUserID" runat="server" />
    <asp:HiddenField ID="hdnShowBtn" runat="server" />
    <asp:HiddenField ID="hdnVersionNo" runat="server" />
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
    <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
        <tr class="GalleryTitle" style="background-image: url('../images/bg_mainHdr_1.jpg');
            height: 31px;">
            <td>
                &nbsp;<span class="IdeaTitle">
                    <asp:UpdatePanel ID="uppUpdateCount" runat="server" RenderMode="Inline">
                        <ContentTemplate>
                            <asp:Literal ID="ltrlUpdateVersionNo" runat="server"></asp:Literal>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </span>
            </td>
            <td align="right">
                &nbsp;<span class="IdeaTitle">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server" RenderMode="Inline">
                        <ContentTemplate>
                            <asp:Literal ID="ltrlCountry" runat="server"></asp:Literal>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </span>
            </td>
        </tr>
        <tr style="height: 41px;">
            <td colspan="2">
                <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="height: 100%;"
                        class="gvwSearchSilver">
                        <tr>
                           
                            <td style="width: 120px;" align="center" id="tdnewbtn" runat="server">
                                <div id="divNewKey" style="padding: 4 2 4 2; width: 100px;" runat="server">
                                    <input id="btnNewGroup" runat="server" type="button" onclick="event.cancelBubble=true;ShowNewGroupDiv_Button();"
                                        class="btnSilver" value="Add New Group" style="width: 100px;" />
                                </div>
                            </td>
                            <td style="padding-right: 5px;">
                                <div class="straightline">
                                </div>
                            </td>
                            <td style="width: 180px;">
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td>
                                            Status:&nbsp;
                                        </td>
                                        <td>
                                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always" RenderMode="Inline">
                                                <ContentTemplate>
                                                    <asp:DropDownList ID="ddlStatus" CssClass="DarkBlackTextSmall" runat="server" Width="120px"
                                                        AutoPostBack="true" EnableViewState="true">
                                                        <asp:ListItem Text="All" Value="-1" Selected="true" />
                                                        <asp:ListItem Text="Schedule" Value="1" />
                                                        <asp:ListItem Text="Not schedule" Value="2" />
                                                    </asp:DropDownList>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td align="right">
                                <table cellpadding="0" cellspacing="0" border="0" style="width: 100px;">
                                    <tr>
                                        <td>
                                            Search:&nbsp;
                                        </td>
                                        <td style="vertical-align:middle;">
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
                            <asp:GridView ID="gvwUpdateGroups" runat="server" AutoGenerateColumns="False" Width="100%"
                                SkinID="gvwSilver" AllowSorting="true" AllowPaging="true" Height="100%" ShowFooter="true"
                                EnableViewState="true" >
                                <Columns>
                                    <asp:TemplateField HeaderText="GroupID" Visible="false">
                                        <ItemTemplate>
                                            <%# Eval("ID")%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Title" SortExpression="Title">
                                        <ItemTemplate>
                                            <%# Eval("Title")%>
                                        </ItemTemplate>
                                        <HeaderStyle Width="15%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Nickname" SortExpression="Name">
                                        <ItemTemplate>
                                            <%# Eval("Name")%>
                                        </ItemTemplate>
                                        <HeaderStyle Width="15%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="# of Stores" SortExpression="StoreCount">
                                        <ItemTemplate>
                                            <%# Eval("StoreCount")%>
                                        </ItemTemplate>
                                        <HeaderStyle Width="10%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Status" SortExpression="StatusName">
                                        <ItemTemplate>
                                            <%# Eval("StatusName")%>
                                        </ItemTemplate>
                                        <HeaderStyle Width="15%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Threshold" SortExpression="Threshold">
                                        <ItemTemplate>
                                            <%# Eval("Threshold")%>
                                        </ItemTemplate>
                                        <HeaderStyle Width="15%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Mandatory" SortExpression="IsMandatory">
                                        <ItemTemplate>
                                            <%# Eval("IsMandatory")%>
                                        </ItemTemplate>
                                        <HeaderStyle Width="15%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Mandatory Date" SortExpression="UpdateMandatoryDate">
                                        <ItemTemplate>
                                            <%# Eval("UpdateMandatoryDate")%>
                                        </ItemTemplate>
                                        <HeaderStyle Width="15%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:ImageButton CommandName="EditGroup" CommandArgument=' <%# Eval("ID")%>' runat="server"
                                                ImageUrl="../images/edit.gif" />
                                        </ItemTemplate>
                                        <HeaderStyle Width="5%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:ImageButton CommandName="DeleteGroup" CommandArgument='<%# Eval("ID")%>' runat="server"
                                                ImageUrl="../images/icn_InActive.png" />&nbsp;&nbsp;
                                        </ItemTemplate>
                                        <HeaderStyle Width="5%" />
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>
                                    <table class="NoRecord">
                                        <tr>
                                            <td>
                                                <img align="absmiddle" src="../../images/ico_alert.gif" />&nbsp;&nbsp;No Group Found
                                                !
                                            </td>
                                        </tr>
                                    </table>
                                </EmptyDataTemplate>
                                <PagerSettings Mode="NextPreviousFirstLast" Visible="true" Position="Bottom" />
                                <PagerTemplate>
                                    <table id="tblPager" width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td style="border: 0; width: 85%;">
                                                Showing Groups
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
                            <asp:AsyncPostBackTrigger ControlID="ddlStatus" EventName="SelectedIndexChanged" />
                            <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnRebindGrid" EventName="Click" />
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
    <div id="divNewGroup" style="display: none; position: absolute; height: 470px; width: 620px;
        top: 61px; left:9px; " >
        <table border="0" cellpadding="0" cellspacing="0" style="height: 470px; width: 620px;"
            class="tblAddFolder pad5px">
            <tr>
                <th colspan="2" align="left" style="height: 25px;">
                    <label id="lblAlbumHeading">
                        </label>
                </th>
            </tr>
            <tr>
                <td align="center">
                    <iframe id="ifNewGroup" width="620px" height="470px" frameborder="0" src="../BlankPage.htm"
                        marginheight="0" marginwidth="0" scrolling="no"></iframe>
                </td>
            </tr>
        </table>
    </div>
    <asp:Button ID="btnRebindGrid" runat="server" Text="Rebind Grid" Style="display: none" />
    <script language="javascript" type="text/javascript" src="../scripts/functions.js"></script>
    <script language="javascript" type="text/javascript">

        function ShowNewGroupDiv_Button() {
            $('#lblAlbumHeading').text("Create new group");
            var queryString = '?GroupID=0&UpdateID=' + getParameterByName('UpdateID') + '&CountryID=' + getParameterByName('CountryID');
            
            ifNewGroup.location = 'groupmanagement.aspx' + queryString;
            divNewGroup.style.left = "10";
            divNewGroup.style.top = getRealTop(divNewKey) + 30;
            
            setTimeout(function () {
                divNewGroup.style.display = 'inline';
                divNewKey.className = "darkGreenColor";
            }, 200); 
        }

        function ShowNewGroupDiv_Grid(GroupID) {
            $('#lblAlbumHeading').text("Edit group");
            var queryString = '?GroupID=' + GroupID + '&UpdateID=' + getParameterByName('UpdateID') + '&CountryID=' + getParameterByName('CountryID');
            ifNewGroup.location = 'groupmanagement.aspx' + queryString;
            divNewGroup.style.left = "10";
            divNewGroup.style.top = getRealTop(divNewKey) + 30;
            setTimeout(function () {
                divNewGroup.style.display = 'inline';
            }, 200); 
        }

        function DeleteGroup(GroupID) {
            var result = confirm("Are you sure to delete the group?");
            if (result == true) {
                $.ajax({
                    type: "POST",
                    url: "UpdateGroups.aspx/DeleteGroupByID",
                    data: "{\"countryID\":\"" + getParameterByName('CountryID') + "\",\"groupID\":\"" + GroupID + "\",\"updateID\":\"" + getParameterByName('UpdateID') + "\"}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        RebindRecords();

                    },
                    failure: function (response) {
                        alert(response.d);
                    }
                });
            }
        }


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



        function CloseNewGroupDiv() {
            divNewGroup.style.display = 'none';
            divNewKey.className = "";
        }

        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
                results = regex.exec(location.search);
            return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }

        function RebindRecords() {
            document.getElementById('<%= btnRebindGrid.ClientID %>').click();
        }  

        
    </script>
    </form>
</body>
</html>