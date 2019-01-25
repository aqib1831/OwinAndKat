
Partial Class LM_DownloadAndInstall
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If String.IsNullOrEmpty(Request.QueryString("Span")) = False Then
            Dim EmailDate As Date = CType(Functions.DecryptData(Request.QueryString("Span")), Date)
            Dim TimeSpan As Integer = DateDiff(DateInterval.Minute, EmailDate, Date.Now)
            If TimeSpan > 1 Then
                Response.Write("Sorry Link time Expire")
            Else
                Response.Write("Download and install SMSx")
            End If
        End If
    End Sub
End Class
