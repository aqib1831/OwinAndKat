
Partial Class SamlResponse
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If String.IsNullOrEmpty(Request.QueryString("SAMLRequest")) = False Then
            SAMLRequest.Value = Request.QueryString("SAMLRequest")
            RelayState.Value = Request.QueryString("RelayState")
            Username.Value = Session("Admin_LogInName")
        End If
    End Sub
End Class
