Partial Class _Default
    Inherits System.Web.UI.Page
    Protected Sub _Default_PreLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreLoad
        If Session("AdminID") = Nothing Then 'If Session has not created
            Response.Redirect("~/Login.aspx")
        End If
    End Sub
End Class
