
Partial Class admin_Legal_LegalHome
    Inherits System.Web.UI.Page

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        ' Admin.ValidateSession()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "SelectIpTab", "parent.onPageLoadTRClick('trID_1');", True)
        If Not HttpContext.Current.Session("Admin_AdminID") Is Nothing Then
            odsMyActivities.SelectParameters.Item("AdminID").DefaultValue = Session("Admin_AdminID")
            odsTodaysActivities.SelectParameters.Item("AdminID").DefaultValue = Session("Admin_AdminID")
        End If
    End Sub
    Protected Sub MyActivities_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles RptrMyActivities.ItemDataBound
        If e.Item.ItemType = ListItemType.Footer Then
            If RptrMyActivities.Items.Count = 0 Then
                e.Item.FindControl("trNoRec").Visible = True
            End If
            lblMyActivitiesCount.Text = RptrMyActivities.Items.Count

        End If
    End Sub
    Protected Function GetArguments(ByVal ID As Object, ByVal type As Object) As String
        Return ID.ToString() & "," & type.ToString()
    End Function
    Protected Sub TodaysActivities_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles RptrTodaysActivities.ItemDataBound
        If e.Item.ItemType = ListItemType.Footer Then
            If RptrTodaysActivities.Items.Count = 0 Then
                e.Item.FindControl("trNoRec").Visible = True
            End If
            lblTodaysActivitiesCount.Text = RptrTodaysActivities.Items.Count
        End If
    End Sub

    Protected Sub RptrAlertsReminders_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.RepeaterCommandEventArgs) Handles RptrAlertsReminders.ItemCommand
        If (e.CommandName.ToUpper().Equals("EDIT") = True) Then
            Dim argument() As String = e.CommandArgument.ToString().Split(",")
            Dim objMgmt As New CaseMgmt()
            If (argument.Length > 0) Then
                objMgmt.NID = argument(0)
                objMgmt.Type = argument(1)
                objMgmt.AlertActions()
            End If
        End If
        RptrAlertsReminders.DataSourceID = odsRemindersAlerts.ID
        RptrAlertsReminders.DataBind()
    End Sub

    Protected Sub RptrAlertsReminders_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles RptrAlertsReminders.ItemDataBound
        If e.Item.ItemType = ListItemType.Footer Then
            If RptrAlertsReminders.Items.Count = 0 Then
                e.Item.FindControl("trNoRecAlert").Visible = True
            End If
            lblAlertsCount.Text = RptrAlertsReminders.Items.Count
        End If
    End Sub
End Class
