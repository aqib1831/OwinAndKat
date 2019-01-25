
Partial Class Mail_Default
    Inherits System.Web.UI.Page

    Protected Sub cmdSignIn_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmdSignIn.Click
        Dim strUserName As String = String.Empty
        Dim strPassword As String = String.Empty
        If txtUserName.Text.ToString <> "" Then
            strUserName = Portal.BLL.Users.ChekLogin_ForGoogle(txtUserName.Text.ToString.ToLower(), txtPassword.Text.ToString)
            If String.IsNullOrEmpty(strUserName) = False Then
                If strUserName.Contains("@netsolace.com.pk") Then
                    LoginToFranMail(strUserName)
                ElseIf strUserName.Contains("@netsolace.com") Then
                    strUserName = strUserName.Replace("@netsolace.com", "")
                    Session("Admin_LogInName") = strUserName
                    Response.Redirect("~/MailSignIn.aspx")
                End If
            Else
                trErrorMessage.Visible = True
                spnError.InnerText = "Invalid username or password"
            End If
        Else
            trErrorMessage.Visible = True
            spnError.InnerText = "Please enter user name to login"
        End If
    End Sub
    Public Function LoginToFranMail(ByVal userName As String) As String

        'Dim objSecure As New us.webmail.secure.Webmail
        Dim obj2 As New us.webmail.secure.Webmail
        Dim AdministrativeUserName As String
        Dim AdministrativePassword As String
        Dim strReturn As String = String.Empty
        Dim strResponse As String = String.Empty
        Dim WebMailSessionID As String = ""
        Dim WebMailUserID As String = ""
        Dim CountryID As String = ""
        Dim strDomain As String = "netsolace.com.pk"
        Dim strLoginUrl As String = String.Empty
        AdministrativeUserName = ConfigurationManager.AppSettings("AdministrativeUserName")
        AdministrativePassword = ConfigurationManager.AppSettings("AdministrativePassword")

        WebMailUserID = Replace(userName, "@netsolace.com.pk", "")
        obj2.ConnectionGroupName = Guid.NewGuid().ToString
        strResponse = obj2.LoginUserWebmail(AdministrativeUserName, AdministrativePassword, strDomain, WebMailUserID, WebMailSessionID)

        obj2.Dispose()

        If WebMailUserID <> "" And WebMailUserID <> "" Then
            'strReturn = "https://" & strLoginUrl & "/mail/src/redirect.php?user_name=" & WebMailUserName & "&emailaddress=" & WebMailUserName & "&sessionID=" & WebMailSessionID
            strReturn = "https://webmail.dofruit.com/mail/src/redirect.php?user_name=" & userName & "&emailaddress=" & userName & "&sessionID=" & WebMailSessionID
            Response.Redirect(strReturn)
        End If

        Return strReturn

    End Function
End Class
