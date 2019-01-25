Imports System.Data.SqlClient
Imports System.Data

Partial Class admin_Legal_NewActivityNote
    Inherits System.Web.UI.Page
    Dim dr As SqlDataReader
    Dim drRem As SqlDataReader
    Dim intellObj As IntellectualProperty = New IntellectualProperty()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        hdnCurrentDate.Text = Now().Date.ToString("MM/dd/yyyy")
        txtReminderDate.Attributes.Add("onfocus", "return showCalendar('txtReminderDate', 'MM/dd/y');")
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ReloadPage", "parent.UpdateParent();", True)
        dr = intellObj.GetSingleActivity(Convert.ToInt32(Request.QueryString("ID")))
        If Request.QueryString("IPID") <> Nothing Then
            hdnIPID.Value = CInt(Request.QueryString("IPID"))
        End If
        If dr.Read() Then

            If Not IsPostBack Then
                Dim st As String = IntellectualProperty.GetNoteTypeID(Convert.ToInt32(dr.Item("Type")))
                lblIPName.Text = Functions.StringTruncate(Server.HtmlEncode(IntellectualProperty.Legal_GetSingleIPName(CInt(hdnIPID.Value))), 40)
                lblIPName.ToolTip = Server.HtmlEncode(IntellectualProperty.Legal_GetSingleIPName(CInt(hdnIPID.Value)))
                lblTimeSpent.Text = dr.Item("TimeSpent").ToString() '.Substring(0, 5)

                lblFrom.Text = IntellectualProperty.Legal_GetAdminName(Convert.ToInt32(dr.Item("UserId")))
                lblCost.Text = Decimal.Round(CType(dr.Item("Cost").ToString(), Decimal), 2)
                If dr.Item("Assigned").ToString() <> "" Then
                    lblAssigned.Text = dr.Item("AssignedTo").ToString()
                Else
                    lblAssigned.Text = "&nbsp;"
                End If
                If dr.Item("Assigned").ToString() <> "" And dr.Item("Assigned").ToString() <> "0" Then
                    If Not ddlAdmins.Items.FindByValue(CInt(dr.Item("Assigned"))) Is Nothing Then
                        ddlAdmins.SelectedValue = CInt(dr.Item("Assigned"))
                    End If

                End If
                lblActivityName.Text = Functions.StringTruncate(Server.HtmlEncode(dr.Item("Subject").ToString()), 40)
                lblType.Text = Server.HtmlEncode(dr.Item("TypeName"))
                If CInt(dr.Item("ActivityState")) = 3 Then
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


            If Convert.ToInt32(dr.Item("UserId")) Then
                intellObj.AdminID = Convert.ToInt32(dr.Item("UserId"))
                intellObj.AID = Convert.ToInt32(Request.QueryString("ID"))
                drRem = intellObj.GetActivityReminder()
                If drRem.Read() Then
                    Session.Add("ReminderID", drRem.Item("ID"))
                    txtReminderDate.Text = drRem.Item("ReminderTime").ToString().Split(" ")(0)
                    ddlTime.SelectedValue = drRem.Item("ReminderTime").ToString().Split(" ")(1) & " " & drRem.Item("ReminderTime").ToString().Split(" ")(2)
                    hdnReminderDate.Value = drRem.Item("ReminderTime").ToString()
                    lblReminderMsg.Text = "Reminder date/time " & drRem.Item("ReminderTime").ToString()
                    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "scrShowAddedRem", "ShowAddedReminder();", True)
                    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "scrShowButtons", " document.getElementById('tdButtons').style.display='inline';document.getElementById('lnkRemAdd').style.display='inline';", True)
                    ddlTime.SelectedValue = drRem.Item("ReminderTime").ToString().Split(" ")(1) & " " & drRem.Item("ReminderTime").ToString().Split(" ")(2)
                    lnkEditRem.Visible = True
                    lnkRemove.Visible = True
                    lnkRemSave.Visible = False
                Else
                    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "scrRemoveAddBut", "document.getElementById('lnkRemAdd').style.display='none';", True)
                    lnkEditRem.Visible = False
                    lnkRemove.Visible = False
                    lnkRemSave.Visible = False
                End If
                drRem.Close()

            End If
            txtReminderDate.Text = Request(txtReminderDate.UniqueID)
            ddlTime.SelectedValue = Request(ddlTime.UniqueID)
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        If Page.IsValid = False Then
            Exit Sub
        End If

        Dim intellObj As IntellectualProperty = New IntellectualProperty()
        Dim dr As SqlDataReader = intellObj.GetSingleActivity(Convert.ToInt32(Request.QueryString("ID")))
        dr.Read()
        intellObj.AID = Convert.ToInt32(Request.QueryString("ID"))
        intellObj.NType = Convert.ToInt32(dr.Item("Type"))
        intellObj.Note = txtNotes.Text
        If txtCost.Text <> "" And IsNumeric(txtCost.Text) Then
            intellObj.Cost = Double.Parse(txtCost.Text)
        Else
            intellObj.Cost = Double.Parse(Decimal.Zero)
        End If
        Dim ts As TimeSpan = New TimeSpan(ddlHours.SelectedValue, ddlMins.SelectedValue, 0)
        intellObj.ActivityTimeSpent = ts
        If dr.Item("Assigned").ToString() <> "" Then
            intellObj.ActivityAsssignedTo = Convert.ToInt32(dr.Item("Assigned"))
        End If

        intellObj.AdminID = Session("AdminID")

        Dim totTime As String() = lblTimeSpent.Text.ToString().Split(":")
        intellObj.UpdateTimeSpent(Convert.ToInt32(Request.QueryString("ID")), ts.Add(New TimeSpan(Convert.ToInt32(totTime(0)), Convert.ToInt32(totTime(1)), 0)))
        intellObj.LID = Convert.ToInt32(Request.QueryString("IPID"))
        intellObj.UpdateIPTime()
        intellObj.UpdateActivityCost(Convert.ToInt32(Request.QueryString("ID")), intellObj.Cost + Decimal.Parse(lblCost.Text))

        intellObj.File1 = FileUpload1
        intellObj.File2 = FileUpload2
        intellObj.File3 = FileUpload3
        intellObj.AddActivityNote()
        intellObj.UpdateLastModified()
        dr.Close()
        Response.Redirect("NewActivityNote.aspx?ID=" & CInt(Request.QueryString("ID")) & "&IPID=" & Request.QueryString("IPID"))
     End Sub

    Protected Sub ddlAdmins_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlAdmins.DataBound
        If Not ddlAdmins.Items.FindByValue(CInt(hdnWaiting.Value)) Is Nothing Then
            ddlAdmins.SelectedValue = CInt(hdnWaiting.Value)
        End If
    End Sub

    Protected Sub ddlActivityState_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlActivityState.SelectedIndexChanged, ddlAdmins.SelectedIndexChanged
        Dim ipObj As IntellectualProperty = New IntellectualProperty()
        ipObj.ActivityState = CInt(ddlActivityState.SelectedValue)
        ipObj.AID = CInt(Request.QueryString("ID"))
        ipObj.WaitingFor = CInt(ddlAdmins.SelectedValue)

        If CType(sender, DropDownList).ID = ddlAdmins.ID Then
            If CInt(ddlActivityState.SelectedValue) = Legal_Enumerations.ActivityState.WaitingFor AndAlso ddlAdmins.SelectedValue <> 0 Then
                ipObj.UpdateIPStatus()
                Exit Sub
            End If
        End If

        If ddlActivityState.SelectedValue = Legal_Enumerations.ActivityState.Complete Then
            ddlClose.Visible = True
            ddlClose.SelectedValue = 2
            ddlActivityState.Visible = False
            ddlAdmins.Visible = False
            With ipObj
                .NType = Legal_Enumerations.NoteType.Other
                .Note = "The activity has been closed."
                .AdminID = Session("AdminId")
                .ActivityTimeSpent = New TimeSpan(0, 0, 1)
                .AddActivityNote()
                .UpdateIPStatus()
            End With
            Response.Redirect("NewActivityNote.aspx?ID=" & CInt(Request.QueryString("ID")) & "&IPID=" & Request.QueryString("IPID"))
        Else
            If CInt(ddlActivityState.SelectedValue) = Legal_Enumerations.ActivityState.WaitingFor Then
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "scrShowAddCheck", "showReminder();", True)
                ddlAdmins.Visible = True
            Else
                ddlClose.Visible = False
                ddlAdmins.Visible = False
                ipObj.UpdateIPStatus()
                Response.Redirect("NewActivityNote.aspx?ID=" & CInt(Request.QueryString("ID")) & "&IPID=" & Request.QueryString("IPID"))
            End If
        End If

    End Sub

    Protected Sub LnkBack_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LnkBack.Click
        If (String.IsNullOrEmpty(Request.QueryString("Source"))) Then
            Response.Redirect("Legal_IP_Activities.aspx?ID=" & hdnIPID.Value.ToString())
        Else
            Response.Redirect(Request.QueryString("Source") & ".aspx?RequestFrom=2&ID=" & hdnIPID.Value.ToString())
        End If

    End Sub

    Protected Sub lnkRemAdd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkRemAdd.Click

        If Page.IsValid = False Then
            Exit Sub
        End If
        lblMsg.Text = ""
        If Convert.ToDateTime(Request(txtReminderDate.UniqueID) & " " & ddlTime.SelectedItem.Text) < DateTime.Now Then
            ClientScript.RegisterStartupScript(Me.GetType(), "scrAlertDate", "alert('Please select future time for reminder');", True)
            Return
        Else
            If Not HttpContext.Current.Session("AdminID") Is Nothing Then
                Dim intellObj As IntellectualProperty = New IntellectualProperty()
                intellObj.AdminID = Session("AdminID")
                intellObj.AID = CInt(Request.QueryString("ID"))

                intellObj.ReminderTime = Convert.ToDateTime(Request(txtReminderDate.UniqueID) & " " & ddlTime.SelectedItem.Text)
                intellObj.AddActivityReminder()
                Response.Redirect("NewActivityNote.aspx?ID=" & Request.QueryString("ID") & "&IPID=" & Request.QueryString("IPID"), True)
            End If
        End If

    End Sub

    Protected Sub lnkEditRem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkEditRem.Click

        txtReminderDate.Text = CType(hdnReminderDate.Value, String).Split(" ")(0)
        ddlTime.SelectedValue = CType(hdnReminderDate.Value, String).Split(" ")(1) & " " & CType(hdnReminderDate.Value, String).Split(" ")(2)
        ClientScript.RegisterStartupScript(Me.GetType(), "scrShowAdd", "/*document.getElementById('chkReminder').checked=true;*//*showReminder();*/ document.getElementById('lnkRemAdd').style.display='none'; document.getElementById('tdReminderMsg').style.display='none';", True)
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
            ClientScript.RegisterStartupScript(Me.GetType(), "scrEditRemove", "alert('Please Enter Future Date/Time.');", True)
            Exit Sub
        Else
            Dim intellObj As IntellectualProperty = New IntellectualProperty()
            intellObj.ReminderTime = Convert.ToDateTime(Request(txtReminderDate.UniqueID) & " " & ddlTime.SelectedItem.Text)
            intellObj.UpdateActivityReminder(Session("ReminderID"), intellObj.ReminderTime)
            Response.Redirect("NewActivityNote.aspx?ID=" & Request.QueryString("ID") & "&IPID=" & Request.QueryString("IPID"), True)


        End If


    End Sub

    Protected Sub lnkRemove_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkRemove.Click

        Dim intellObj As IntellectualProperty = New IntellectualProperty()
        intellObj.DeleteActivityReminder(Session("ReminderID"))

        Response.Redirect("NewActivityNote.aspx?ID=" & Request.QueryString("ID") & "&IPID=" & Request.QueryString("IPID"), True)
       

    End Sub

    Protected Sub ddlNType_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlNType.DataBound
        ddlNType.Items.Insert(0, New ListItem("Choose...", "-1"))
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
        Response.Redirect("NewActivityNote.aspx?ID=" & CInt(Request.QueryString("ID")) & "&IPID=" & Request.QueryString("IPID"))
    End Sub

    'Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
    '    dr.Close()
    'End Sub

    Protected Sub Repeater1_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles Repeater1.ItemDataBound
        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then
            If e.Item.DataItem("ID") = e.Item.DataItem("OriginalNoteID") Then
                CType(e.Item.FindControl("lblNotesCaption"), Label).Text = "Original message sent "
            End If
        End If
    End Sub
End Class
