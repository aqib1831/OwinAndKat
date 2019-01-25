
Partial Class BlankPage
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Response.Write("<" & "script>window.top.location.replace('ErrorPage.aspx');</" & "script>")
    End Sub
End Class
