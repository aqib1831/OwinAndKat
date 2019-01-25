Partial Class admin_Legal_Legal_AddActivity
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            lblDate.Text = DateTime.Now.ToShortDateString()
        End If
        lblDate.Text = Request(lblDate.UniqueID)
    End Sub
End Class
