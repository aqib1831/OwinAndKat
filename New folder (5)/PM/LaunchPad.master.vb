
Partial Class MyNetsolace_MyNetsolace
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        If Context.Session Is Nothing Or Context.Session.Count < 1 Then
            Response.Redirect("SessionExpired.htm")
        End If
    End Sub
End Class

