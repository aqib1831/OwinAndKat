
Partial Class admin_Legal_CaseMain
    Inherits System.Web.UI.Page

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        If Not Request.QueryString("ActivityID") Is Nothing Then
            If Request.QueryString("ActivityID").ToString() <> "" Then
                ClientScript.RegisterStartupScript(Me.GetType(), "CaseSearch", "RightFrame.location='NewCaseNote.aspx?ID=" & Request.QueryString("ActivityID") & "&CaseID=" & Request.QueryString("ID") & "';", True)
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
End Class
