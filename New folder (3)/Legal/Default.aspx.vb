
Partial Class admin_Legal_Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If String.IsNullOrEmpty(Request.QueryString("MySocket")) = False Then
            If String.IsNullOrEmpty(Request.QueryString("CaseID")) = False Then
                frameMain.Attributes.Add("src", "CaseMain.aspx?ActivityID=" & Request.QueryString("ID") & "&ID=" & Request.QueryString("CaseID") & "&MySocket=1")
            Else
                frameMain.Attributes.Add("src", "IPMain.aspx?ActivityID=" & Request.QueryString("ID") & "&ID=" & Request.QueryString("IPID") & "&MySocket=1")
            End If
        End If
    End Sub

End Class
