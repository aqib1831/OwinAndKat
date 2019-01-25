
Partial Class KB_Default
    Inherits System.Web.UI.Page

#Region "page Events"
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.Title = "Netsolace Portal - Knowledge Base"
        Me.Master.SelectedIcon = Portal.BLL.Enumeration.Modules.KnowlegeBase
        If String.IsNullOrEmpty(Request.QueryString("Change")) = False AndAlso IsNumeric(Request.QueryString("Change")) = True Then
            IFrame.Attributes.Add("src", "List_Categories.aspx")
        End If
    End Sub
#End Region

End Class

