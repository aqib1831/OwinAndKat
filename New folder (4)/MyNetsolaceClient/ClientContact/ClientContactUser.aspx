<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ClientContactUser.aspx.vb"
    Inherits="MyNetsolace_ClientContactUser" Theme="Default" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Users</title>
</head>
<body style="margin: 0; padding: 0; height: 100%; width: 100%">
    <form id="form1" runat="server">
    <div>
        <asp:HiddenField ID="hdnClientID" runat="server" />
        <asp:HiddenField ID="hdnSearch" runat="server" />
        <asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="300" />
        <asp:UpdateProgress ID="Progress1" runat="server">
            <ProgressTemplate>
                <div class="ProgressIndicatorDivGray" style="right: 20px; bottom: 40px">
                    <br />
                    <img src="../../images/indicator.gif" align="absmiddle" /><b>&nbsp;&nbsp;Loading ...</b>
                    <br />
                    <br />
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
        <table style="height: 100%; width: 100%" cellspacing="0" border="0" cellpadding="0">
            <tr class="GalleryTitle" style="background-image: url('../../images/bg_mainHdr_1.jpg');
                height: 31px;">
                <td style="height: 31px; background-color: #A0CDEE; font-size: 12px; padding: 5px;
                    width: 50%;">
                    <asp:UpdatePanel ID="upRecordCount" runat="server" UpdateMode="Always">
                        <ContentTemplate>
                            <span style="font-weight: bold;">Manage Users&nbsp;|&nbsp;<asp:Label ID="lblRecordCount"
                                runat="server" Text="0"></asp:Label></span>&nbsp;(<asp:Literal ID="ltrlFiltered"
                                    runat="server" Text="All"></asp:Literal>)
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
                <td style="background-color: #A0CDEE; font-size: 12px; font-weight: bold; padding: 3px;
                    color: #437494; text-align: right;">
                    &nbsp;&nbsp;&nbsp;&nbsp;                    
                    <asp:ImageButton ID="imgResetFilter" runat="server" style="cursor:pointer" OnClientClick="resetFilters();" ImageUrl="~/images/btn_ResetFilters.jpg" />                      
                    <img align="absmiddle" src="../../images/pixel_skyBlue.jpg" width="1" height="20" />
                </td>
            </tr>
            <tr>
                <td colspan="2" style="height: 40px; font-size: 11px; border-top: 0px;">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="gvwSearchSilver"
                        style="position: relative; top: -2px;">
                        <tr>
                            <td style="width: 100px;" align="center" id="tdnewbtn">
                                <div id="divNewKey" style="padding: 4 2 4 2; width: 90px;">
                                    <input id="btnNewUser" type="button" onClick="javascript:window.location='ClientContactNewUser.aspx'"
                                        class="btnSilver" value="NEW USER" style="width: 80px;" /></div>
                            </td>
                            <td>
                                <div class="straightline">
                                </div>
                            </td>
                            <td style="padding-left: 5px; padding-right: 5px; width: 110px;">
                                <span style="font-size: 7pt; color: #7c8798">Filter</span><br />
                                <asp:DropDownList ID="ddlInActive" runat="server" SkinID="SmallTextCombo" AutoPostBack="True"
                                    Width="100px">
                                    <asp:ListItem Selected="True" Value="0">Show All</asp:ListItem>
                                    <asp:ListItem Value="1">Active</asp:ListItem>
                                    <asp:ListItem Value="2">InActive</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                <div class="straightline">
                                </div>
                            </td>
                            <td style="padding-left: 5px; padding-right: 5px; width: 110px;">
                                <span style="font-size: 7pt; color: #7c8798">User Type</span><br />
                                <asp:DropDownList ID="ddlUserType" runat="server" SkinID="SmallTextCombo" AutoPostBack="True"
                                    Width="100px">
                                    <asp:ListItem Selected="True" Value="-1">Show All</asp:ListItem>
                                    <asp:ListItem Value="0">User</asp:ListItem>
                                    <asp:ListItem Value="1">Admin</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                <div class="straightline">
                                </div>
                            </td>                            
                            <td style="white-space: nowrap; padding-left: 5px;">
                                <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch">
                                    <span class="GreyTextSmall">Search</span><br />
                                    <span>
                                        <asp:TextBox ID="txtSearch" runat="server" MaxLength="50" onkeyup="if(CheckNoisyWord()==false) return false;"
                                            onfocus="javascript:this.value='';" Width="100px" />
                                        <asp:ImageButton ID="btnSearch" runat="server" OnClientClick="if(CheckNoisyWord()==false) return false; trPager.style.display='none';"
                                            ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" />
                                    </span>
                                </asp:Panel>
                            </td>
                            <td style="width: 25%;">
                                &nbsp;&nbsp;
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="height: 100%;">
                    <div id="divScroll" style="height: 100%; width: 100%; overflow-y: auto;" class="GrayScrollBar">
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Always" RenderMode="Inline">
                            <ContentTemplate>
                                <asp:GridView ID="gvUsers" runat="server" SkinID="gvwSilver" DataKeyNames="ID" DataSourceID="ODS_GetAll"
                                    EnableViewState="False" AutoGenerateColumns="False" Width="100%" AllowPaging="true" AllowSorting="true" Height="100%" ShowFooter="true">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Name" SortExpression="Name" HeaderStyle-Width="23%">
                                            <ItemTemplate>
                                                <div title="<%#CType(Container.DataItem, Data.DataRowView)("Name")%>" class="TextWrap">
                                                    <%#CType(Container.DataItem, Data.DataRowView)("Name")%></div>
                                            </ItemTemplate>                                            
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="JobTitle" SortExpression="JobTitle" HeaderStyle-Width="15%">
                                            <ItemTemplate>
                                                <div title="<%#CType(Container.DataItem, Data.DataRowView)("JobTitle")%>" class="TextWrap">
                                                    <%#CType(Container.DataItem, Data.DataRowView)("JobTitle")%></div>
                                            </ItemTemplate>                                            
                                        </asp:TemplateField>                                        
                                        <asp:TemplateField HeaderText="Email" SortExpression="Email" HeaderStyle-Width="15%">
                                            <ItemTemplate>
                                                <div title='<%#CType(Container.DataItem, Data.DataRowView)("Email1")%>' class="TextWrap">
                                                <%#CType(Container.DataItem, Data.DataRowView)("Email1")%></div>
                                            </ItemTemplate>                                            
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="User Type" SortExpression="UserType" HeaderStyle-Width="7%">
                                            <ItemTemplate>
                                                <div title='<%#CType(Container.DataItem, Data.DataRowView)("UserType")%>' class="TextWrap">
                                                <%#CType(Container.DataItem, Data.DataRowView)("UserType")%></div>
                                            </ItemTemplate>                                            
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Phone" SortExpression="Phone" HeaderStyle-Width="10%">
                                            <ItemTemplate>
                                                <div title='<%#CType(Container.DataItem, Data.DataRowView)("WorkPhone")%>' class="TextWrap">
                                                <%#CType(Container.DataItem, Data.DataRowView)("WorkPhone")%></div>
                                            </ItemTemplate>                                            
                                        </asp:TemplateField>
                                    </Columns>
                                    <PagerTemplate>
                                        <table id="tblPager" width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td style="border: 0; width: 85%;">
                                                    Showing Users
                                                    <asp:Literal ID="ltrlStartCount" runat="server" Text="0"></asp:Literal>
                                                    to
                                                    <asp:Literal ID="ltrlEndCount" runat="server" Text="0"></asp:Literal>
                                                    of
                                                    <asp:Literal ID="ltrlTotalCount" runat="server" Text="0"></asp:Literal>
                                                </td>
                                                <td style="border: 0;" align="right">
                                                    Page&nbsp;<asp:Literal ID="ltrlStartPage" runat="server" Text="0"></asp:Literal>
                                                    of
                                                    <asp:Literal ID="ltrlLastPage" runat="server" Text="0"></asp:Literal>&nbsp;&nbsp;&nbsp;<asp:LinkButton
                                                        ID="lnkBtnFirst" runat="server" CommandName="page" CommandArgument="first">
                                                        <asp:Image ID="imgFirst" runat="server" ImageUrl="../../../admin/RnD/images/First_blk.jpg"
                                                            ToolTip="First" /></asp:LinkButton>&nbsp;<asp:LinkButton ID="lnkBtnPrevious" runat="server"
                                                                CommandName="page" CommandArgument="prev">
                                                                <asp:Image ID="imgPrevious" runat="server" ImageUrl="../../../../admin/RnD/images/back_blk.jpg"
                                                                    ToolTip="Previous" /></asp:LinkButton>
                                                    &nbsp;<asp:LinkButton ID="lnkBtnNext" runat="server" CommandName="page" CommandArgument="next">
                                                        <asp:Image ID="imgNext" runat="server" ImageUrl="../../../../admin/RnD/images/Next_blk.jpg"
                                                            ToolTip="Next" /></asp:LinkButton>&nbsp;<asp:LinkButton ID="lnkBtnLast" runat="server"
                                                                CommandName="page" CommandArgument="last">
                                                                <asp:Image ID="imgLast" runat="server" ImageUrl="../../../../admin/RnD/images/Last_blk.jpg"
                                                                    ToolTip="Last" /></asp:LinkButton>&nbsp;&nbsp;&nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </PagerTemplate>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="ddlInActive" EventName="SelectedIndexChanged" />
                                <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="imgResetFilter" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="ddlUserType" EventName="SelectedIndexChanged" />                                
                            </Triggers>
                        </asp:UpdatePanel>
                        <asp:ObjectDataSource ID="ODS_GetAll" runat="server" EnableViewState="true" SortParameterName="sortExpression"
                            SelectMethod="ClientsContactsGetAll" TypeName="Portal.BLL.Client.Client_Contacts"
                            SelectCountMethod="ClientsContactsGetAllCount" MaximumRowsParameterName="maximumRows"
                            StartRowIndexParameterName="startRowIndex" EnablePaging="True" OldValuesParameterFormatString="">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="hdnClientID" DefaultValue="1" Name="ClientID" PropertyName="Value"
                                    Type="Int32" />                                
                                <asp:ControlParameter ControlID="ddlUserType"  Name="UserType" PropertyName="SelectedValue"
                                    Type="Int32" />
                                <asp:ControlParameter ControlID="ddlInActive" DefaultValue="0" Name="InActive" PropertyName="SelectedValue"
                                    Type="Int32" />                                
                                <asp:Parameter Name="sortExpression" DefaultValue="" Type="String" />
                                <asp:ControlParameter ControlID="txtSearch" DefaultValue="" Name="txtsearch" PropertyName="Text"
                                    Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                    </div>
                </td>
            </tr>
            <tr id="trPager" class="gvwSilverPager" style="display: none;">
            <td id="tdPager" colspan="2">
            </td>
        </tr>  
        </table>
    </div>

    <script type="text/javascript" src="../../scripts/functions.js"></script>   
    <script type="text/javascript" language="javascript">
        function resetFilters() {            
            document.getElementById('<%= ddlInActive.ClientID %>').value = 0;
            document.getElementById('<%= ddlUserType.ClientID %>').value = -1;
        }

        function ShowUserDetail(trClicked, userId) {
            trClicked.className = "SelectedRow";
            var str = 'ClientContactNewUser.aspx?UserID=' + userId;
            str += '&ddlInActive=' + document.getElementById('<%=ddlInActive.ClientID%>').value;            
            str += '&UserType=' + document.getElementById('<%=ddlUserType.ClientID%>').value;
            str += '&txtSearch=' + document.getElementById('<%=hdnSearch.ClientID%>').value;
            window.location = str
        }
        function CheckNoisyWord() {
            var mybool = true;
            var InputStr = document.getElementById('<%= txtsearch.ClientID %>').value;
            if (CheckSpecailChar(InputStr) == true) {
                alert("Special characters are not Allowed.\nPlease remove them and try again.");
                document.getElementById('<%= txtSearch.ClientID %>').value = '';
                mybool = false;
                return false;
            }
            if (mybool == false)
                return false;
            else
                return true;
        }

        FixPagerAndFooter();
        function FixPagerAndFooter() {
            //Adjust footer
            if (getElementByClassName("gvwSilverFooter") != null) {
                if (parseInt(parseInt(parseInt(getElementByClassName("gvwSilverFooter").rowIndex) - 1) % 2) != 0) {
                    getElementByClassName("gvwSilverFooter").className = "gvwSilverFooter";
                }
            }

            //Adjust pager            
            if (getElement("tblPager") != null) {
                trPager.style.display = "inline";
                tdPager.innerHTML = getElement("tblPager").outerHTML;
                getElementByClassName("gvwSilverPager").style.display = "none";
            }
            else {
                trPager.style.display = "none";
            }
        }

        var postbackElement;
        Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(beginRequest);
        Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(pageLoaded);

        function beginRequest(sender, args) {
            postbackElement = args.get_postBackElement();
        }

        function pageLoaded(sender, args) {
            var updatedPanels = args.get_panelsUpdated();
            if (typeof (postbackElement) === "undefined") {
                return;
            }
            for (i = 0; i < updatedPanels.length; i++) {
                if (updatedPanels[i].id == '<%= UpdatePanel2.ClientID %>') {
                    document.getElementById('<%= hdnSearch.ClientID %>').value = document.getElementById('<%= txtsearch.ClientID %>').value
                    document.getElementById('<%= txtsearch.ClientID %>').value = '';                    
                    FixPagerAndFooter();
                }
            }
        }
	
    </script>

    </form>
</body>
</html>
