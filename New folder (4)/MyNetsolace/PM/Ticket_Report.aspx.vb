
Partial Class admin_HelpDesk_History_Report
    Inherits System.Web.UI.Page

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateMyNetsolaceSession()
    End Sub


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request.QueryString("type") = 2 Then
            Response.Buffer = True
            Response.AddHeader("content-disposition", "attachment; filename=MyNetsolace PM Report.xls")
            Response.ContentType = "application/vnd.ms-excel"
        End If
    End Sub

    Protected Sub Page_SaveStateComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.SaveStateComplete
        If rptMyNetsolace.Items.Count < 1 Then
            lblPrinted.Visible = True
            lblPrinted.Text = "No Record found!"
            lblTotal.Text = " 0 "
        Else
            lblTotal.Text = rptMyNetsolace.Items.Count.ToString
            lblPrinted.Visible = False
        End If

    End Sub
End Class
