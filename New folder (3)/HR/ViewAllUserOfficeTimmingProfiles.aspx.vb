
Partial Class HR_ViewAllUserOfficeTimmingProfiles
    Inherits System.Web.UI.Page
    Dim Counter As Integer = 0

    Protected Sub btnReloadRepeater_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReloadRepeater.Click
        Portal.BLL.HR.UserOfficeTimingProfiles.DeleteOfficeTimingProfile(Me.hdnProfileID.Value)
        Me.rptProfiles.DataSourceID = "odsProfiles"
        rptProfiles.DataBind()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Page.IsPostBack = False Then
            ltrlDate.Text = DateTime.Now.ToString("dddd, MMMM d") & "<sup>" & Functions.GetSuperScript(DateTime.Now.Day) & "</sup>" & " " & DateTime.Now.Year
        End If
    End Sub

    Protected Sub rptProfiles_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptProfiles.ItemDataBound
        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            Counter = Counter + 1
        ElseIf e.Item.ItemType = ListItemType.Footer Then
            If Counter = 0 Then
                Me.dvNoRecord.Visible = True
            Else
                Me.dvNoRecord.Visible = False
            End If
        End If
    End Sub
End Class
