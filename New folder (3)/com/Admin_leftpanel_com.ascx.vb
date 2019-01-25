Imports Portal.BLL

Partial Class contacts_leftpanel_PM
    Inherits System.Web.UI.UserControl

    Protected intStoreCount As Integer = 0
    Protected SelectedValue As Integer = 0

#Region " Private Members "

    Private _Selected As Integer = 0

#End Region

#Region " Public Properties "

    Public Property FranchiseID() As String
        Get
            Return hdnFranchiseID.Value
        End Get
        Set(ByVal value As String)
            hdnFranchiseID.Value = value
        End Set
    End Property

    Public Property PortalClientID() As String
        Get
            Return ddlClient.SelectedValue
        End Get
        Set(ByVal value As String)
            ddlClient.SelectedValue = value
            hdnClientID.Value = value
        End Set
    End Property
#End Region

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
		If Not Page.IsPostBack Then
            Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            sdsClients.DataBind()
            ddlClient.DataBind()
            hdnSubModuleID.Value = Portal.BLL.Enumeration.SubModules.HelpDesk
            'Selecting the proper client
            'If Not Request.QueryString("ClientID") Is Nothing And IsNumeric(Request.QueryString("ClientID")) Then
            '    ddlClient.SelectedValue = "0"
            'Else
            '    ddlClient.SelectedValue = "0"
            'End If
            ddlClient.Attributes.Add("onchange", "changeClient();")
        End If
        hdnClientID.Value = ddlClient.SelectedValue
    End Sub

    Protected Sub rptStores_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptStores.ItemDataBound
        If e.Item.ItemType = ListItemType.Header Then
            intStoreCount = 0
        ElseIf e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            intStoreCount += 1
        ElseIf e.Item.ItemType = ListItemType.Footer Then
            If intStoreCount > 0 Then
                CType(e.Item.FindControl("trStores_NoRecord"), HtmlTableRow).Visible = False
            Else
                CType(e.Item.FindControl("trStores_NoRecord"), HtmlTableRow).Visible = True
            End If
        End If
    End Sub

    Protected Sub ddlStates_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlStates.DataBound
        ddlStates.Items.Insert(0, New ListItem("Show All", "0"))
    End Sub

    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSearch.Click
        If txtSearch.Text <> String.Empty Or CInt(ddlStates.SelectedValue) > 0 Then
            divStores.Attributes.Add("Style", "display:inline;")
        Else
            divStores.Attributes.Add("Style", "display:none;")
        End If
    End Sub

    Protected Sub ddlStates_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlStates.SelectedIndexChanged
        If CInt(ddlStates.SelectedValue) > 0 Or txtSearch.Text <> String.Empty Then
            divStores.Attributes.Add("Style", "display:inline;")
            SelectedValue = ddlStates.SelectedValue
        Else
            divStores.Attributes.Add("Style", "display:none;")
        End If
    End Sub

    Protected Sub ddlClient_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlClient.DataBound
        ddlClient.Items.Insert(0, New ListItem("Show All", "0"))
        Dim ClientIDlist As String
        For Each item As ListItem In ddlClient.Items
            ClientIDlist += item.Value + ","
        Next
        ClientIDlist.Remove(ClientIDlist.LastIndexOf(","))
        hdnClientIDList.Value = ClientIDlist
    End Sub

End Class