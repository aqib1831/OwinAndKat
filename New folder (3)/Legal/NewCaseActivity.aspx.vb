Partial Class admin_Legal_NewLegalActivity
    Inherits System.Web.UI.Page


    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        'If Page.IsValid = False Then
        '    Exit Sub
        'End If
        '  If Not HttpContext.Current.Session("Admin_AdminID") Is Nothing Then
        If String.IsNullOrEmpty(HttpContext.Current.Session("AdminId")) = False Then
            Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
        End If
        Dim addNote As CaseMgmt = New CaseMgmt()
        addNote.NType = CInt(ddlNType.SelectedValue)
        addNote.CID = Convert.ToInt32(Request.QueryString("ID"))
        addNote.Note = txtNote.Text
        addNote.TimeSpent = New TimeSpan(CInt(ddlHoursNotes.SelectedValue), CInt(ddlMinutesNotes.SelectedValue), 0).ToString()
        Dim status As Integer = CInt(ddlActivityState.SelectedValue)
        addNote.ActivityAssignedTo = CInt(ddlActivityAssginedTo.SelectedValue)
        If status = 3 Then
            addNote.AStatus = 0
            addNote.CloseDate = DateTime.Now
        ElseIf status = 4 Then
            addNote.AssignedTo = CInt(ddlAssignedTo.SelectedValue)
            addNote.AStatus = 1
        Else
            addNote.AStatus = 1
        End If
        addNote.ActivitySate = CInt(ddlActivityState.SelectedValue)
        addNote.Subject = txtSubject.Text
        addNote.AdminID = Session("AdminID")
        addNote.File1 = Me.FileUpload1
        addNote.File2 = Me.FileUpload2
        addNote.File3 = Me.FileUpload3

        If chkReminder.Checked Then
            addNote.AID = addNote.AddLegalActivity()
            addNote.ReminderTime = Convert.ToDateTime(Request(txtReminderDate.UniqueID) & " " & ddlTime.SelectedItem.Text)
            addNote.AddActivityReminder()
            ClientScript.RegisterStartupScript(Me.GetType(), "ReloadParent", "parent.frameMain.location='CaseMain.aspx?ID=" & Request.QueryString("ID") & "';", True)

        Else
            addNote.AID = addNote.AddLegalActivity()
            ClientScript.RegisterStartupScript(Me.GetType(), "ReloadParent", "parent.frameMain.location='CaseMain.aspx?ID=" & Request.QueryString("ID") & "';", True)
        End If

        ''Else
        '' Response.Redirect("SessionExpire.htm")
        '' End If
    End Sub

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
  
        lblCaseName.Text = Server.HtmlEncode(CType(CaseMgmt.GetSingleCaseName(CInt(Request.QueryString("ID"))), String))
        hdnCurrentDate.Text = Now().Date.ToString("MM/dd/yyyy")
        txtReminderDate.Attributes.Add("onfocus", "return showCalendar('txtReminderDate', 'MM/dd/y');")
    End Sub

    Protected Sub ddlNType_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlNType.DataBound
        ddlNType.Items.Insert(0, New ListItem("Choose...", "-1"))
    End Sub


End Class
