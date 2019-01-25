Partial Class URLM_UrlmMain
    Inherits System.Web.UI.Page


    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.Master.SelectedIcon = Portal.BLL.Enumeration.Modules.URLM
    End Sub
    Protected Sub URLM_UrlmMain_PreRenderComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRenderComplete
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "AdjustHeight", "AdjustHeightForSafari();", True)
    End Sub
End Class