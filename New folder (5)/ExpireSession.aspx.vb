Imports Microsoft.VisualBasic

Partial Class ExpireSession
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Response.Write("<" & "script>window.top.location.replace('Login.aspx');</" & "script>")        
    End Sub
End Class
