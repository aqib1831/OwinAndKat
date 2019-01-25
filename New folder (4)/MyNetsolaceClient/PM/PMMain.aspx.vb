
Partial Class PM_PMMain
    Inherits System.Web.UI.Page
    Protected intTicketCount As Integer = 0

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateMyNetsolaceSession()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Me.Master.SelectedIcon = 4 'Portal MyNetsolace PM
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "HideSearchDivPanel", "HideSearchDiv();", True)
        End If
    End Sub
    Protected Sub rptStores_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptStores.ItemDataBound
        If e.Item.ItemType = ListItemType.Header Then
            intTicketCount = 0
        ElseIf e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            intTicketCount += 1
        ElseIf e.Item.ItemType = ListItemType.Footer Then
            If intTicketCount > 0 Then
                CType(e.Item.FindControl("trStores_NoRecord"), HtmlTableRow).Visible = False
            Else
                CType(e.Item.FindControl("trStores_NoRecord"), HtmlTableRow).Visible = True
            End If
        End If
    End Sub

    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSearch.Click
        If txtSearch.Text.Trim <> String.Empty Then
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "HidePanel", "HideLeftPanel();", True)
        Else
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "HideSearchDivPanel", "HideSearchDiv();", True)
        End If
    End Sub

End Class
