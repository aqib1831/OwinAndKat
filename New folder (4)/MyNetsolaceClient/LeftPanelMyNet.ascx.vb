Imports System.Data
Partial Class MyNetsolace_LeftPanelMyNet
    Inherits System.Web.UI.UserControl
    

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Request.QueryString("ClientID") Is Nothing AndAlso IsNumeric(Request.QueryString("ClientID")) Then
            hdnClientID.Text = Request.QueryString("ClientID")
            ltrlnXtepCount.Text = "- " & Portal.BLL.LicenseManagement.GetAllNextStepLicensesCount("", hdnClientID.Text, 0, 0)
            ltrlDMenuCount.Text = "- " & Portal.BLL.LM.DMenuLicenseManagement.GetAllDMenuLicensesCount("", hdnClientID.Text, 0, 0)
        End If
    End Sub
End Class
