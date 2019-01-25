
Partial Class MyNetsolace_ClientContactMainPage
    Inherits System.Web.UI.Page
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateMyNetsolaceSession()
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.Page.Title = "Netsolace Portal - My Netsolace"
        Me.Master.SelectedIcon = 5 'Client Contact
        If Request.QueryString("Module") = "4" Then
            'Me.lftforhelpDesk.Visible = False
            Me.lftforAdmin.Visible = True
            iframeMain.Attributes.Add("src", "../MyNetsolace/ClientContactUser.aspx")
        End If
    End Sub


End Class
