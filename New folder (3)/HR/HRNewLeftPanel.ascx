<%@ Control Language="VB" AutoEventWireup="false" CodeFile="HRNewLeftPanel.ascx.vb" Inherits="HR_HRNewLeftPanel" %>
<script language="javascript" type="text/javascript" src="../scripts/jquery-1.3.2.min.js"></script>
<table id="tblLeftMenu" width="170px" border="0" cellpadding="0" cellspacing="0" style="border: solid 0px #EEEDE5;
    height: 100%;" bgcolor="#DDEEFE">
    <tr>
        <td colspan="2" style="text-align: center; height: 100px;">
            <div>
                <img alt="" border="0" src="images/hr_leftpanel.png" />
            </div>
        </td>
    </tr>
    <asp:Repeater id="rptNewHRModules" runat="server" DataSourceID="odsSubModules">
        <ItemTemplate>
            <tr id="trLink<%#Eval("ID") %>" onclick="javascript:RedirectURL('<%#Eval("LinkURL")%>','<%#Eval("ID")%>');" class="leftPanel_Normal">
                <td style="width: 19px; padding-left: 5px;" align="absmiddle">
                    <div width="17px" height="31" align="center" />
                </td>
                <td align="left" style="width: 100%; padding-left: 5px;">
                    &nbsp;<a href="#"><%#Eval("Name")%></a>
                </td>
            </tr>
        </ItemTemplate>
    </asp:Repeater>
    <asp:ObjectDataSource ID="odsSubModules" runat="server" TypeName="Portal.HRModule" SelectMethod="GetSubModulesInsideNewHR">
        <SelectParameters>
            <asp:ControlParameter ControlID="hdnUserID" Name="UserID" />
            <asp:ControlParameter ControlID="hdnMainModuleID" Name="MainModuleID" />
        </SelectParameters>
    </asp:ObjectDataSource>    
    <tr onclick="javascript:MoveBack();" id="tr3" class="leftPanel_Normal"
        style="display: inline;">
        <td style="width: 19px; padding-left: 5px;" align="absmiddle">
            <div width="17px" height="31" align="center" />
        </td>
        <td align="left" style="width: 100%; padding-left: 5px;">
            &nbsp;<a href="#">Old Interface</a>
        </td>
    </tr>
    <tr>
        <td colspan="3">
            &nbsp;
        </td>
    </tr>
</table>

<asp:HiddenField id="hdnUserID" runat="server" />
<asp:HiddenField id="hdnClientID" runat="server" />
<asp:HiddenField id="hdnMainModuleID" runat="server" />

<script type="text/javascript" language="javascript">

    function RedirectURL(PageName, PageID) {
        NewChangeTrBackGroundNew(PageID);
        IfHR.location = PageName; 
    }
    function NewChangeTrBackGroundNew(PageID) {
        $(".leftPanel_Selected").removeClass().addClass("leftPanel_Normal");
        $("#trLink" + PageID).addClass("leftPanel_Selected");
    }
    function MoveBack() {
        $(".leftPanel_Selected").removeClass().addClass("leftPanel_Normal");
        $("#tr3").addClass("leftPanel_Selected");
        window.location = 'HRMain.aspx';
    }
    
</script>