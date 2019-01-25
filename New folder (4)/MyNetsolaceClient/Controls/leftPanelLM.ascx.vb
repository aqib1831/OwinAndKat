Imports System.Data

Partial Class LM_leftPanelLM
    Inherits System.Web.UI.UserControl

    Protected Sub imgBtnSearch_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgBtnSearch.Click
        Dim dtLicenses As New DataTable
        If (String.IsNullOrEmpty(txtSearch.Text.Trim.ToString()) = False) Then
            dtLicenses = Portal.BLL.LicenseManagement.GetAllNextStepLicenses(txtSearch.Text.Trim(), 1, -1, 0, "Title", 0, 100)
            rptSearchLicenses.DataSource = dtLicenses
            rptSearchLicenses.DataBind()
        End If
    End Sub

    Protected Sub rptSearchLicenses_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptSearchLicenses.ItemDataBound
        If (rptSearchLicenses.Items.Count = 0) Then
            ltrlNoRecord.Visible = True
            rptSearchLicenses.Visible = False
        Else
            ltrlNoRecord.Visible = False
            rptSearchLicenses.Visible = True
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Request.QueryString("ClientID") Is Nothing AndAlso IsNumeric(Request.QueryString("ClientID")) Then
            hdnClientID.Text = Request.QueryString("ClientID")
            ltrlnXtepCount.Text = "- " & Portal.BLL.LicenseManagement.GetAllNextStepLicensesCount("", hdnClientID.Text, 0, 0)
            ltrlDMenuCount.Text = "- " & Portal.BLL.LM.DMenuLicenseManagement.GetAllDMenuLicensesCount("", hdnClientID.Text, 0, 0)
        End If
    End Sub
End Class
