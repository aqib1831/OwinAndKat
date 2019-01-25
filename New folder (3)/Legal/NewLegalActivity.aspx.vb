
Partial Class admin_Legal_NewLegalActivity
    Inherits System.Web.UI.Page
    

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        If Page.IsValid = False Then
            Exit Sub
        End If

        Dim addNote As IntellectualProperty = New IntellectualProperty
        addNote.NType = CInt(ddlNType.SelectedValue)
        addNote.LID = Convert.ToInt32(Request.QueryString("ID"))
        addNote.Note = txtNote.Text
        addNote.ActivityState = CInt(ddlActivityState.SelectedValue)
        addNote.ActivityAsssignedTo = CInt(ddlAssignedTo.SelectedValue)
        addNote.Subject = txtSubject.Text
        addNote.ActivityTimeSpent = New TimeSpan(ddlHoursNotes.SelectedValue, ddlMinutesNotes.SelectedValue, 0)
        addNote.ActivityAsssignedTo = CInt(ddlActivityAssginedTo.SelectedValue)
        Dim status As Integer = CInt(ddlActivityState.SelectedValue)
        If status = 3 Then
            addNote.AStatus = 0
            addNote.CloseDate = DateTime.Now
        Else
            addNote.AStatus = 1
        End If
        If status = 4 Then
            addNote.AssignedTo = ddlAssignedTo.SelectedValue
        End If
        addNote.AdminID = Session("AdminID")
        addNote.File1 = Me.FileUpload1
        addNote.File2 = Me.FileUpload2
        addNote.File3 = Me.FileUpload3
        If chkReminder.Checked Then
            addNote.AID = addNote.AddLegalActivity()
            addNote.ReminderTime = Convert.ToDateTime(Request(txtReminderDate.UniqueID) & " " & ddlTime.SelectedItem.Text)
            addNote.AddActivityReminder()
            ClientScript.RegisterStartupScript(Me.GetType(), "ReloadParent", "parent.frameMain.location='IPMain.aspx?ID=" & Request.QueryString("ID") & "';", True)

        Else
            addNote.AID = addNote.AddLegalActivity()

            ClientScript.RegisterStartupScript(Me.GetType(), "ReloadParent", "parent.frameMain.location='IPMain.aspx?ID=" & Request.QueryString("ID") & "';", True)
        End If

      
    End Sub

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        
        lblIPName.Text = Server.HtmlEncode(Functions.StringTruncate(IntellectualProperty.Legal_GetSingleIPName(Request.QueryString("ID")), 30))
        hdnCurrentDate.Text = Now().Date.ToString("MM/dd/yyyy")
        txtReminderDate.Attributes.Add("onfocus", "return showCalendar('txtReminderDate', 'MM/dd/y');")
    End Sub

    Protected Sub ddlNType_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlNType.DataBound
        ddlNType.Items.Insert(0, New ListItem("Choose...", "-1"))
    End Sub
End Class
