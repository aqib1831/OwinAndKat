
Partial Class Reports_LeftPanel_Reports
    Inherits System.Web.UI.UserControl
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ltrlSMSxVersionCount.Text = "- " & Portal.BLL.SMSXLicenseManagement.GetAllSMSXLicensesSMSxVersionCount("All", 0)
    End Sub

End Class
