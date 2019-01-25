
Partial Class HR_MainMasterPage
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            CheckAcess()
            Me.Master.DataBind()
            If Request.QueryString("PunchMode") = 0 Then
                ifMainMasterPage.Attributes.Add("src", "CardPunch.aspx?key=" & Request.QueryString("key"))
            Else
                ifMainMasterPage.Attributes.Add("src", "Default.aspx?key=" & Request.QueryString("key"))
            End If
            HttpContext.Current.Session.RemoveAll()
            HttpContext.Current.Session.Abandon()
            HttpContext.Current.Session.Clear()
        End If
    End Sub

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
