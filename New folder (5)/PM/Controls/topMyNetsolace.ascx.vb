
Partial Class MyNetsolace_Controls_topMyNetsolace
    Inherits System.Web.UI.UserControl

    Protected Sub lnkSingout_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkSingout.Click
        HttpContext.Current.Session.RemoveAll()
        Response.Redirect("~/PM/SucessFulLogout.htm", True)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load    
        tblHome.Attributes.Add("onclick", "window.location='LaunchPadMainPage.aspx?" & Request.QueryString().ToString() & "';")
        If Not IsPostBack Then
            If Not Context.Session Is Nothing And Context.Session.Count > 0 Then
                lblUserName.Text = Session("AdminName")
            End If
        End If
    End Sub
End Class
