Imports System.Data.SqlClient
Imports System.Data
Partial Class Users_ChangePassword
    Inherits System.Web.UI.Page

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        If String.IsNullOrEmpty(HttpContext.Current.Session("AdminID")) Then
            HttpContext.Current.Response.Redirect("https://qa.netsolace.com/Portal/mail/Logout.aspx?change=1&hl=en")
        End If
    End Sub

    Protected Sub BtnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnSave.Click

        Dim Result As Boolean = False
        Dim objUsers As New Portal.BLL.Users
        If objUsers.Update_GoogleAccount(CInt(Session("AdminID")), NewPassword.Text.Trim) Then
            Result = objUsers.UpdateFranMailPassword(CInt(Session("AdminID")), NewPassword.Text.Trim)
        End If

        If Result Then
            Response.Redirect("mail/Logout.aspx?change=2")
        Else
            trErrorMessage.Attributes.Add("style", "display:inline")
            spnError.InnerText = "Please try again later."
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lblEmailAddress.Text = Portal.BLL.Users.GetFranmail_UserName(HttpContext.Current.Session("AdminID"))
    End Sub
End Class
