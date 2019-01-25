
Partial Class MyNetsolace_MainPage
    Inherits System.Web.UI.Page

    Protected intStoreCount As Integer = 0

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateMyNetsolaceSession()
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        hdnClientId.Value = Session("MyNetsolace_ClientID")

        Me.Page.Title = "Netsolace Portal - Area Developer "
        If Request.QueryString("Module") = "1" Or Request.QueryString("Module") = "" Then
            Me.Master.SelectedIcon = 1 'help desk            
            Me.Master.SelectedIcon = 4 'Portal PM
            Response.Redirect("~/AreaDeveloper/PM/PMMain.aspx")
            Return
        End If

        If Request.QueryString("Module") = "4" Then
            Me.Master.SelectedIcon = 4 'Portal PM
            iframeMain.Attributes.Add("src", "PMMain.aspx")
        End If
    End Sub

End Class
