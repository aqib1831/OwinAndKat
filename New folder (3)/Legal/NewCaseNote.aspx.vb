Imports System.Data.SqlClient
Imports System.Data.Sql
Imports System.Data

Partial Class admin_Legal_NewCaseNote
    Inherits System.Web.UI.Page

    Dim caseObj As CaseMgmt = New CaseMgmt()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If String.IsNullOrEmpty(HttpContext.Current.Session("AdminId")) = False Then
            Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
        End If
        txtReminderDate.Attributes.Add("onfocus", "return showCalendar('txtReminderDate', 'MM/dd/y');")
        hdnCurrentDate.Text = Now().Date.ToString("MM/dd/yyyy")
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ReloadPage", "parent.UpdateParent();", True)
        If Request.QueryString("CaseID") <> Nothing Then
            hdnCaseID.Value = CInt(Request.QueryString("CaseID"))
        End If
        Dim dr As SqlDataReader = Nothing
        dr = caseObj.GetSingleActivity(Convert.ToInt32(Request.QueryString("ID")))
        If dr.Read() Then
            hdnActivityState.Value = dr.Item("ActivityState").ToString()
            If Not Page.IsPostBack Then
                lblAssignedTo.Text = dr.Item("AssignedTo").ToString()
                If dr.Item("ActivityState") = 3 Then
                    ddlActivityState.SelectedValue = CInt(dr.Item("ActivityState"))
                    ddlClose.Visible = True
                    ddlClose.SelectedValue = 2
                    ddlActivityState.Visible = False
                    ddlAdmins.Visible = False
                Else
                    If CInt(dr.Item("ActivityState")) = 4 Then
                        ddlActivityState.SelectedValue = CInt(dr.Item("ActivityState"))
                        ddlActivityState.Visible = True
                        ddlAdmins.Visible = True
                        ddlClose.Visible = False
                    Else
                        ddlActivityState.Visible = True
                        ddlActivityState.SelectedValue = CInt(dr.Item("ActivityState"))
                        ddlClose.Visible = False
                        ddlAdmins.Visible = False

                    End If
                End If
                hdnWaiting.Value = CInt(dr.Item("Assigned"))
            End If

            lblFrom.Text = Server.HtmlEncode(dr.Item("AdminName").ToString())
            lblType.Text = Server.HtmlEncode(dr.Item("TypeName"))
            Dim dr1 As SqlDataReader = New CaseMgmt().GetSingleCase(CInt(Request.QueryString("CaseID")))
            If dr1.Read() Then
                lblCaseName.Text = Functions.StringTruncate(Server.HtmlEncode(dr1.Item("Title").ToString()), 40)
                lblCaseName.ToolTip = Server.HtmlEncode(dr1.Item("Title").ToString())
            End If
            dr1.Close()
            lblTimeSpent.Text = CaseMgmt.GetTimeSpent(dr.Item("TimeSpent"))
            lblSubject.Text = Server.HtmlEncode(Functions.StringTruncate(dr.Item("Subject").ToString(), 50))
            lblSubject.ToolTip = Server.HtmlEncode(dr.Item("Subject").ToString())
            lblCost.Text = Decimal.Round(CType(dr.Item("Cost").ToString(), Decimal), 2)
            caseObj.AdminID = Session("AdminID")
            caseObj.AID = Convert.ToInt32(Request.QueryString("ID"))
            Dim drRem As SqlDataReader = caseObj.GetActivityReminder()
            If drRem.Read() Then
                Session.Add("ReminderID", drRem.Item("ID"))
                txtReminderDate.Text = drRem.Item("ReminderTime").ToString().Split(" ")(0)
                ddlTime.SelectedValue = drRem.Item("ReminderTime").ToString().Split(" ")(1) & " " & drRem.Item("ReminderTime").ToString().Split(" ")(2)
                lblReminderMsg.Text = "Reminder date/time " & drRem.Item("ReminderTime").ToString()
                hdnReminderDate.Value = drRem.Item("ReminderTime").ToString()
                ClientScript.RegisterStartupScript(Me.GetType(), "scrCallShowReminder", "ShowAddedReminder();", True)
                ClientScript.RegisterStartupScript(Me.GetType(), "scrShowReminderLink", " document.getElementById('tdButtons').style.display='inline';document.getElementById('lnkRemAdd').style.display='inline';", True)

                ddlTime.SelectedValue = drRem.Item("ReminderTime").ToString().Split(" ")(1) & " " & drRem.Item("ReminderTime").ToString().Split(" ")(2)
                lnkEditRem.Visible = True
                lnkRemove.Visible = True
                lnkRemSave.Visible = False
            Else
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "scrHideReminderLink", "document.getElementById('lnkRemAdd').style.display='none';", True)
                lnkEditRem.Visible = False
                lnkRemove.Visible = False
                lnkRemSave.Visible = False
            End If
            drRem.Close()
            If dr IsNot Nothing Then
                dr.Close()
            End If

        End If

        'End If
        txtReminderDate.Text = Request(txtReminderDate.UniqueID)
        ddlTime.SelectedValue = Request(ddlTime.UniqueID)
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        If Page.IsValid = False Then
            Exit Sub
        End If
        Dim caseObj As CaseMgmt = New CaseMgmt()
        If Not HttpContext.Current.Session("AdminID") Is Nothing Then
            caseObj.AID = Convert.ToInt32(Request.QueryString("ID"))
            caseObj.NType = Convert.ToInt32(ddlNType.SelectedValue)
            caseObj.Note = txtNotes.Text
            Dim ts As TimeSpan = New TimeSpan(ddlHours.SelectedValue, ddlMins.SelectedValue, 0)
            caseObj.TimeSpent = ts.ToString()
            caseObj.ActivityAssignedTo = ddlAdmins.SelectedValue
            caseObj.Reminder = chkReminder.Checked
            caseObj.ReminderTime = Convert.ToDateTime(Request(txtReminderDate.UniqueID) & " " & ddlTime.SelectedItem.Text)
            If txtCost.Text <> "" Then
                caseObj.Cost = Double.Parse(txtCost.Text)
            Else
                caseObj.Cost = Double.Parse(Decimal.Zero)
            End If

            caseObj.AdminID = Session("AdminID")
            caseObj.File1 = FileUpload1
            caseObj.File2 = FileUpload2
            caseObj.File3 = FileUpload3
            caseObj.AddCaseNote()
            If chkReminder.Checked Then
                caseObj.ReminderTime = Convert.ToDateTime(Request(txtReminderDate.UniqueID) & " " & ddlTime.SelectedItem.Text)
                caseObj.AddActivityReminder()
            End If
            Dim totTime As String() = lblTimeSpent.Text.ToString().Split(":")
            caseObj.UpdateTimeSpent(Convert.ToInt32(Request.QueryString("ID")), ts.Add(New TimeSpan(Convert.ToInt32(totTime(0)), Convert.ToInt32(totTime(1)), 0)))
            caseObj.UpdateActivityCost(Convert.ToInt32(Request.QueryString("ID")), caseObj.Cost + Decimal.Parse(lblCost.Text))
            caseObj.UpdateCaseCost(Convert.ToInt32(Request.QueryString("CaseID")))
            caseObj.CID = CInt(Request.QueryString("CaseID"))
            caseObj.UpdateCaseTime()
            caseObj.UpdateLastModified()
             ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ReloadPage", "parent.UpdateParent();", True)
            Response.Redirect("NewCaseNote.aspx?ID=" & CInt(Request.QueryString("ID")) & "&CaseID=" & Request.QueryString("CaseID"))
        Else
            Response.Redirect("SessionExpire.htm")
        End If
    End Sub

    Protected Sub ddlAdmins_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlAdmins.DataBound
        If Not ddlAdmins.Items.FindByValue(CInt(hdnWaiting.Value)) Is Nothing Then
            ddlAdmins.SelectedValue = CInt(hdnWaiting.Value)
        End If
    End Sub

    Protected Sub ddlActivityState_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlActivityState.SelectedIndexChanged, ddlAdmins.SelectedIndexChanged
        Dim caseObj As CaseMgmt = New CaseMgmt()
        caseObj.AID = CInt(Request.QueryString("ID"))
        caseObj.ActivitySate = CInt(ddlActivityState.SelectedValue)
        caseObj.WaitingFor = CInt(ddlAdmins.SelectedValue)

        If CType(sender, DropDownList).ID = ddlAdmins.ID Then
            If CInt(ddlActivityState.SelectedValue) = Legal_Enumerations.ActivityState.WaitingFor AndAlso ddlAdmins.SelectedValue <> 0 Then
                caseObj.UpdateCaseStatus()
                Exit Sub
            End If
        End If

        If ddlActivityState.SelectedValue = Legal_Enumerations.ActivityState.Complete Then
            ddlClose.Visible = True
            ddlClose.SelectedValue = 2
            ddlActivityState.Visible = False
            ddlAdmins.Visible = False
            With caseObj
                .NType = Legal_Enumerations.NoteType.Other
                .Note = "The activity has been closed."
                .AdminID = Session("AdminID")
                .Cost = 0
                .TimeSpent = "00:00"
                .AddCaseNote()
                .UpdateCaseStatus()
            End With
            Response.Redirect("NewCaseNote.aspx?ID=" & CInt(Request.QueryString("ID")) & "&CaseID=" & Request.QueryString("CaseID"))
        Else
            If CInt(ddlActivityState.SelectedValue) = Legal_Enumerations.ActivityState.WaitingFor Then
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "scrShowAddCheckRem", "showReminder();", True)
                ddlAdmins.Visible = True
            Else ' Not Started , In Progress
                ddlClose.Visible = False
                ddlAdmins.Visible = False
                caseObj.UpdateCaseStatus()
                Response.Redirect("NewCaseNote.aspx?ID=" & CInt(Request.QueryString("ID")) & "&CaseID=" & Request.QueryString("CaseID"))
            End If
        End If

    End Sub

    Protected Sub LnkBack_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LnkBack.Click
        If (String.IsNullOrEmpty(Request.QueryString("Source"))) Then
            Response.Redirect("Legal_Case_Activities.aspx?ID=" & hdnCaseID.Value.ToString())
        Else
            Response.Redirect(Request.QueryString("Source") & ".aspx?RequestFrom=1&ID=" & hdnCaseID.Value.ToString())
        End If

    End Sub


    Protected Sub lnkRemAdd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkRemAdd.Click
        If Page.IsValid = False Then
            Exit Sub
        End If
        lblMsg.Text = ""
        If Convert.ToDateTime(Request(txtReminderDate.UniqueID) & " " & ddlTime.SelectedItem.Text) < DateTime.Now Then
            ClientScript.RegisterStartupScript(Me.GetType(), "scrAlertFutureTime", "alert('Please select future time for reminder.');", True)
            Return
        Else
            If Not HttpContext.Current.Session("AdminID") Is Nothing Then
                Dim CaseObj As IntellectualProperty = New IntellectualProperty()
                CaseObj.AdminID = Session("AdminID")
                CaseObj.AID = CInt(Request.QueryString("ID"))
                CaseObj.ReminderTime = Convert.ToDateTime(Request(txtReminderDate.UniqueID) & " " & ddlTime.SelectedItem.Text)
                CaseObj.AddActivityReminder()
                Response.Redirect("NewCaseNote.aspx?ID=" & Request.QueryString("ID") & "&CaseID=" & Request.QueryString("CaseID"), True)
            End If
        End If
    End Sub

    Protected Sub lnkEditRem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkEditRem.Click
        txtReminderDate.Text = CType(hdnReminderDate.Value, String).Split(" ")(0)
        ddlTime.SelectedValue = CType(hdnReminderDate.Value, String).Split(" ")(1) & " " & CType(hdnReminderDate.Value, String).Split(" ")(2)
        ClientScript.RegisterStartupScript(Me.GetType(), "ShowAdd", "SaveReminder();document.getElementById('chkReminder').checked=true;showReminder(); document.getElementById('lnkRemAdd').style.display='none'; document.getElementById('tdReminderMsg').style.display='none';", True)
        chkReminder.Visible = True
        chkReminder.Enabled = False
        chkReminder.Checked = True
        lnkRemSave.Visible = True
        lnkEditRem.Visible = False
        lnkRemove.Visible = False
    End Sub

    Protected Sub lnkRemSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkRemSave.Click
        If Page.IsValid = False Then
            Exit Sub
        End If
        lblMsg.Text = ""
        If Convert.ToDateTime(Request(txtReminderDate.UniqueID) & " " & ddlTime.SelectedItem.Text) < DateTime.Now Then
            lnkEditRem.Style.Add("display", "none")
            lnkRemove.Style.Add("display", "none")
            lnkRemAdd.Style.Add("display", "none")
            lnkRemSave.Visible = True
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "scrAlert", "alert('Please Enter Future Date/Time.');", True)
            Return
        Else
            Dim CaseObj As IntellectualProperty = New IntellectualProperty()
            CaseObj.ReminderTime = Convert.ToDateTime(Request(txtReminderDate.UniqueID) & " " & ddlTime.SelectedItem.Text)
            CaseObj.UpdateActivityReminder(Session("ReminderID"), CaseObj.ReminderTime)
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "scrShowEditRemove", "EditReminder();", True)
            Response.Redirect("NewCaseNote.aspx?ID=" & Request.QueryString("ID") & "&CaseID=" & Request.QueryString("CaseID"), True)
            chkReminder.Visible = False
            lnkEditRem.Visible = True
            lnkRemove.Visible = True
            lnkRemAdd.Visible = False
            lnkRemSave.Visible = False
            lblReminderMsg.Visible = True
        End If
    End Sub

    Protected Sub lnkRemove_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkRemove.Click
        Dim CaseObj As IntellectualProperty = New IntellectualProperty()
        CaseObj.DeleteActivityReminder(Session("ReminderID"))
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "scrShowAdd", "showReminder();", True)
        Response.Redirect("NewCaseNote.aspx?ID=" & Request.QueryString("ID") & "&CaseID=" & Request.QueryString("CaseID"), True)

        txtReminderDate.Text = ""
        chkReminder.Checked = False
        ddlTime.SelectedIndex = 0
        lnkEditRem.Visible = False
        lnkRemove.Visible = False
        lnkRemAdd.Visible = True
        lnkRemSave.Visible = False

    End Sub

    Protected Sub ddlNType_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlNType.DataBound
        ddlNType.Items.Insert(0, New ListItem("Choose...", "-1"))
        ddlNType.Items.Add(New ListItem("Bill", "50"))
    End Sub

    Protected Sub ddlClose_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlClose.SelectedIndexChanged
        ddlClose.Visible = False
        ddlActivityState.Visible = True
        ddlActivityState.SelectedIndex = 0
        Dim caseObj As CaseMgmt = New CaseMgmt()
        caseObj.AID = CInt(Request.QueryString("ID"))
        caseObj.ActivitySate = CInt(ddlActivityState.SelectedValue)
        caseObj.WaitingFor = CInt(ddlAdmins.SelectedValue)
        caseObj.UpdateCaseStatus()
        If ddlActivityState.SelectedValue = 3 Then
            ddlActivityState.SelectedValue = CInt(hdnActivityState.Value)
            ddlClose.Visible = True
            ddlClose.SelectedValue = 2
            ddlActivityState.Visible = False
            ddlAdmins.Visible = False
        Else
            If CInt(hdnActivityState.Value) = 4 Then
                ddlActivityState.SelectedValue = CInt(hdnActivityState.Value)
                ddlActivityState.Visible = True
                ddlAdmins.Visible = True
                ddlClose.Visible = False
            Else
                ddlActivityState.Visible = True
                ddlActivityState.SelectedValue = CInt(hdnActivityState.Value)
                ddlClose.Visible = False
                ddlAdmins.Visible = False

            End If
        End If
        Response.Redirect("NewCaseNote.aspx?ID=" & CInt(Request.QueryString("ID")) & "&CaseID=" & Request.QueryString("CaseID"))
    End Sub

    Protected Sub Repeater1_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles Repeater1.ItemDataBound
        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then
            If e.Item.DataItem("ID") = e.Item.DataItem("OriginalNoteID") Then
                CType(e.Item.FindControl("lblNotesCaption"), Label).Text = "Original message sent "
            End If
        End If
    End Sub

End Class
