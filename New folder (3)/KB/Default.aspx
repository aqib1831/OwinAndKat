<%@ Page Language="VB" MasterPageFile="~/main.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="KB_Default" %>
<%@ Register Src="left_Panel.ascx" TagName="left_Panel" TagPrefix="uc1" %>
<%@ MasterType VirtualPath="~/main.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" Runat="Server">

        <table width="100%" style="margin: 0px; vertical-align: top; height: 100%; border: 0px;
            width: 100%;background-color: #E4F1F7;" cellpadding="0" cellspacing="3" >
            <tr bgcolor="#D8EAFC">
                <td valign="top" style="height: 100%; width: 20%; display: block; padding: 0px;
                    border: 1px solid #609BD3;" id="tdLeftPanel">
                    <uc1:left_Panel ID="Left_Panel1" runat="server"  />
                   
                </td>
                <td style="font-size: 11px; display: block; background-color: #E4F1F7; width: 80%; height: 100%;
                    margin: 0px; border: 1px solid #609BD3;" valign="top">                 
                    <iframe name="IFrame" runat="server" id="IFrame" src="RecentCreatedTopics.aspx"
                        style="margin: 0px; width: 100%; height: 100%; border: 0px;"
                        frameborder="0" scrolling="no"></iframe>                 
                </td>
            </tr>
        </table>
</asp:Content>

