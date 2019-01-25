
Partial Class Communication_CommMain
    Inherits System.Web.UI.Page
    Protected intTicketCount As Integer = 0

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            '    If CType(Session("IstVisit"), Boolean) <> False Then
            '        Me.Master.SelectedIcon = Portal.BLL.Enumeration.Modules.ProjectManagement
            '        If String.IsNullOrEmpty(Request.QueryString("Page")) = False Then
            '            IfCommuication.Attributes.Add("src", Request.QueryString("Page") & "&ID=" & Request.QueryString("ID") & "&PrevPage=" & Request.QueryString("PrevPage") & "&ClientID=" & Request.QueryString("ClientID"))
            '        End If
            '    End If
            '    ClientScript.RegisterStartupScript(Me.GetType, "SetBackGround", "ChangeTrBackGround(2);", True)
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "HideSearchDivPanel", "HideSearchDiv();", True)

            If Request.QueryString("GoToEdit") <> String.Empty AndAlso Request.QueryString("GoToEdit") Then
                Dim NewsID = Request.QueryString("ID")
                Dim LetterID = Request.QueryString("LetterID")
                IfCommuication.Attributes.Add("src", "WeeklyLetter_Update.aspx?" & "ID=" & NewsID & "&LetterID=" & LetterID)
            End If
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
