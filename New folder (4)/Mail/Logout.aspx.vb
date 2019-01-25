
Partial Class Mail_Logout
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If String.IsNullOrEmpty(Request.QueryString("Change")) = False Then
            If Request.QueryString("Change") = 1 Then
                lblMsg.Text = "You are not authorized to change the password!"
	    ElseIf Request.QueryString("Change") = 2 Then
                lblMsg.Text = "Password has been changed successfully!"
            End If
        Else
            lblMsg.Text = "You have successfully logged out!"
        End If
    End Sub

End Class
