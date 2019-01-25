
Partial Class admin_Legal_CaseMain
    Inherits System.Web.UI.Page

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If String.IsNullOrEmpty(HttpContext.Current.Session("AdminId")) = False Then
            Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
        End If

        If Not Request.QueryString("ActivityID") Is Nothing Then
            If Request.QueryString("ActivityID").ToString() <> "" Then
                ClientScript.RegisterStartupScript(Me.GetType(), "CaseSearch", "RightFrame.location='NewActivityNote.aspx?ID=" & Request.QueryString("ActivityID") & "&IPID=" & Request.QueryString("ID") & "';", True)
            End If
        End If
    End Sub
    Public Shared Function ChkNullDescription(ByVal Desc As Object) As String
        If Desc Is Nothing Then
            Return ""
        Else
            Return Desc.ToString().Replace(vbCrLf, "")
        End If
        Return ""
    End Function

    Protected Sub btnBinder_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnBinder.Click
        fvLeadVitals.DataBind()
    End Sub

    Public Shared Function ShowHyphenBetweenDates(ByVal Date1 As Object, ByVal Date2 As Object) As String
        If Date1 Is DBNull.Value Or Date2 Is DBNull.Value Then
            Return ""
        Else
            Return " - "
        End If
    End Function

End Class
