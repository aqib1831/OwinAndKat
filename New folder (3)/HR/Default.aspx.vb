
Partial Class HR_Default
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            CheckAcess()
            ''ScriptManager.RegisterStartupScript(Me, Me.GetType, "SetFocus", "document.getElementById('" & txtEmployeeID.ClientID & "').focus();", True)
            txtEmployeeID.Focus()
            If String.IsNullOrEmpty(Request.QueryString("IsSucessfull")) = False AndAlso CBool(Request.QueryString("IsSucessfull")) Then
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "reset1", "message();", True)
                lbErrMessage.Text = "You Have Sucessfully Punched Out."
                Me.lbErrMessage.ForeColor = Drawing.Color.DarkGreen
            ElseIf String.IsNullOrEmpty(Request.QueryString("IsSucessfull")) = False AndAlso CBool(Request.QueryString("IsSucessfull")) = False Then
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "reset2", "message();", True)
                lbErrMessage.Text = "You Have Sucessfully Punched In."
                Me.lbErrMessage.ForeColor = Drawing.Color.DarkGreen
            End If
            HttpContext.Current.Session.RemoveAll()
            HttpContext.Current.Session.Abandon()
            HttpContext.Current.Session.Clear()
        End If
    End Sub


    Protected Sub btnEmployeeLogin_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnEmployeeLogin.Click
        Dim intReturnValue As Integer

        intReturnValue = AuthenticateUser()
        lbErrMessage.Text = intReturnValue
        ''intReturnValue = -1
        If txtEmployeeID.Text.Length = 0 Or txtPassword.Text.Length = 0 Then
            lbErrMessage.Text = "Please enter username and password!"
        Else
            If intReturnValue < 0 Then
                If intReturnValue = -1 Then
                    lbErrMessage.Text = "Invalid Username!"
                    Me.txtEmployeeID.Text = ""
                    Me.txtEmployeeID.Focus()
                    Me.txtPassword.Text = ""
                    Me.lbErrMessage.ForeColor = Drawing.Color.Red
                ElseIf intReturnValue = -2 Then
                    lbErrMessage.Text = "Invalid Password!"
                    Me.txtPassword.Text = ""
                    Me.txtPassword.Focus()
                    Me.lbErrMessage.ForeColor = Drawing.Color.Red
                End If
            Else
                FormsAuthentication.RedirectFromLoginPage(txtEmployeeID.Text, False)
                Response.Redirect("TimeCard.aspx")

            End If
        End If
    End Sub

    Private Function AuthenticateUser() As Integer

        Dim objHRUsers As Portal.BLL.HR.HR_Activities = New Portal.BLL.HR.HR_Activities()
        Dim intReturnValue As Integer

        objHRUsers.UserName = txtEmployeeID.Text
        objHRUsers.Password = txtPassword.Text
        intReturnValue = objHRUsers.HR_Authenticate()
        Session.Add("HRTimeZoneOffSet", objHRUsers.TimeZoneID)
        Session.Add("HRAdminID", objHRUsers.ID)
        Session.Add("TeamID", objHRUsers.TeamID)
        Return intReturnValue
    End Function


    Private Function PageIPAuthentication() As Boolean
        If (CBool(ConfigurationManager.AppSettings("HRIPCheck")) = True) Then
            Dim strIPs As String = CStr(ConfigurationManager.AppSettings("HRAllowedIPS"))
            Dim strIPArray As String() = strIPs.Split(",")
            For i As Integer = 0 To strIPArray.Length - 1
                If strIPArray(i).Trim() = HttpContext.Current.Request.UserHostAddress.ToString().Trim() Then
                    Return True
                End If
            Next
            Return False
        Else
            Return True
        End If
    End Function

    Private Sub CheckAcess()
        If String.IsNullOrEmpty(Request.QueryString("key")) = False Then
            If Functions.DecryptData(Request.QueryString("key")) <> CStr(ConfigurationManager.AppSettings("HRKey")) Then
                Response.Redirect("~/AccessDenied.aspx", True)
            End If
        Else
            Response.Redirect("~/AccessDenied.aspx", True)
        End If
        If (PageIPAuthentication() = False) Then
            Response.Redirect("~/AccessDenied.aspx", True)
        End If
    End Sub

End Class
