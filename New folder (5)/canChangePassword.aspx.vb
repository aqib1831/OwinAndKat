
Partial Class canChangePassword
    Inherits System.Web.UI.Page

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        If String.IsNullOrEmpty(HttpContext.Current.Session("AdminID")) Then
            HttpContext.Current.Response.Redirect("https://qa.netsolace.com/Portal/mail/logout.aspx?change=1&hl=en")
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Portal.BLL.Users.CanChange_Password(Session("AdminID")) Then
            Response.Redirect("Users_ChangePassword.aspx")
        Else
            Response.Redirect("https://qa.netsolace.com/Portal/mail/logout.aspx?change=1&hl=en")
        End If
    End Sub
End Class
