
Partial Class HR_test
    Inherits System.Web.UI.Page
   
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If String.IsNullOrEmpty(Request.QueryString("Type")) = False AndAlso Request.QueryString("Type") = 1 Then
            LocalTime(Now)
        Else
            UserLocalTime(Now)
        End If
    End Sub
    Private Sub LocalTime(ByVal dtm As DateTime)
        Dim strIPs As String = CStr(ConfigurationManager.AppSettings("NetsolaceIsbIP"))
        Dim strIPArray As String() = strIPs.Split(",")
        For i As Integer = 0 To strIPArray.Length - 1
             If strIPArray(i).Trim() = HttpContext.Current.Request.UserHostAddress.ToString().Trim() Then
                 HdnUserTime.Value = Functions.GetTimeByZone(ConfigurationManager.AppSettings("NetsolaeIsbTimeOffset"), Now)
                 Return
             End If
        Next
        HdnUserTime.Value = Now
    End Sub
    Private Sub UserLocalTime(ByVal dtm As DateTime)
        HdnUserTime.Value = Functions.GetTimeByZone(Session("HRTimeZoneOffSet"), Now)
    End Sub
End Class
