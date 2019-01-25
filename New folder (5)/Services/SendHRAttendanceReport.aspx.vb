Imports System.Net

Partial Class Services_SendHRAttendanceReport
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim objWebClient As New WebClient
        Dim objUTF8Encoding As New UTF8Encoding
        Dim strResponse As String = String.Empty
        Dim url As String = ConfigurationManager.AppSettings("NetsolacePortalUrl").ToString() & "HR/LateArrivals.aspx?Token=" & ConfigurationManager.AppSettings("TokentoViewHRReport").ToString()
        If (String.IsNullOrEmpty(Request.QueryString("IsSupport")) = False) Then
            url = url & "&IsSupport=1"
        End If
        Try
            strResponse = objUTF8Encoding.GetString(objWebClient.DownloadData(url))
            Dim objEmail As New Portal.BLL.Email
            objEmail.MailFrom = "portal@netsolace.com"
            objEmail.MailTo = "wkhalid@broadpeakit.com,akhan@broadpeakit.com,ftajammul@broadpeakit.com,aqadeer@broadpeakit.com"
            objEmail.MailBCC = "kshahzad@broadpeakit.com"
            objEmail.Subject = "Employees Absent/Late Arrival Report"
            objEmail.Detail = strResponse
            objEmail.Send_mail()
        Catch ex As Exception
            'Thorw the exception
        Finally
            objWebClient.Dispose()
        End Try
    End Sub
End Class
