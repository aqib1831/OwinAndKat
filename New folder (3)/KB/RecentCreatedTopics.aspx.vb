
Partial Class KB_RecentCreatedTopics
    Inherits System.Web.UI.Page

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    Protected Sub lnkAddTopic_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkAddTopic.Click
        Response.Redirect("List_Categories.aspx")
    End Sub
End Class
