Imports System.Collections.Generic
Partial Class HR_UsersTimeHistoryAddNew
    Inherits System.Web.UI.Page
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            MEV_MEE_txtPunchOutTime.Enabled = False
            CV_CompareTime.Enabled = False
            hdnMode.Value = "NewMode"
            CV_txtDate.Visible = False
            LoadStores(String.Empty)
            If Not String.IsNullOrEmpty(Request.QueryString("UserID")) Then
                If IsNumeric(Request.QueryString("UserID")) Then
                    Me.ddlUsers.SelectedValue = Request.QueryString("UserID")
                    hdnUserSelected.Value = Request.QueryString("UserID")
                    SetTimeTeam()
                End If
            End If
        End If
    End Sub

    Protected Sub ddlUsers_ItemsRequested(ByVal o As Object, ByVal e As Telerik.WebControls.RadComboBoxItemsRequestedEventArgs) Handles ddlUsers.ItemsRequested
        LoadStores(e.Text)
    End Sub
    Private Sub LoadStores(ByVal byvalsearch As String)
        Dim db As New DBAccess
        Dim dt As System.Data.DataTable
        db.AddParameter("@Search", byvalsearch)
        dt = db.ExecuteDataTable("HR_Users_GetAll_ForRadCombo")
        ddlUsers.DataSource = dt
        ddlUsers.DataBind()
    End Sub
    Private Sub RadComboBox1_ItemDataBound(ByVal o As Object, ByVal e As Telerik.WebControls.RadComboBoxItemDataBoundEventArgs) Handles ddlUsers.ItemDataBound
        e.Item.Text = CType(e.Item.DataItem, System.Data.DataRowView)("Name").ToString()
    End Sub
    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim objUserTimeHistory As New Portal.BLL.HR.HR_UserTimeHistory
        Dim objHR_UserTimeHistory As New Portal.BLL.HR.HR_UserTimeHistory
        If Page.IsValid Then
            With objUserTimeHistory
                If hdnMode.Value = "NewMode" Then
                    .ID = 0
                    .UserID = ddlUsers.Value
                    .PunchInTime = DateTime.Parse(txtDate.Text & " " & txtPunchInTime.Text)
                    If txtPunchOutTime.Text = "" Then
                        .PunchOutTime = DateTime.Parse(DateTime.MaxValue)
                    Else
                        .PunchOutTime = DateTime.Parse(txtDate.Text & " " & txtPunchOutTime.Text)
                        If Portal.BLL.Enumeration.TeamType.Support_Night = hdnTeamID.Value AndAlso _
                            CType(txtDate.Text & " " & txtPunchInTime.Text, DateTime) > CType(txtDate.Text & " " & txtPunchOutTime.Text, DateTime) Then
                            .PunchOutTime = DateTime.Parse(CDate(txtDate.Text).AddDays(1) & " " & txtPunchOutTime.Text)
                        End If
                    End If

                    .LastAccessTime = DateTime.Now
                    .ForcedPunchOut = False
                    .Deleted = False
                    .LastUpdatedBy = Session("AdminID")
                    .LastUpdatedNotes = txtNotes.Text.Trim()
                    .CreationType = 2
                    .AttendenceType = ddlAttendenceRecordTypes.SelectedValue
                    .HR_UserTimeHistoryAdd(.ID, .UserID, .PunchInTime, .PunchOutTime, .LastAccessTime, .ForcedPunchOut, .Notes, .Deleted, .LastUpdatedBy, .LastUpdatedNotes, .CreationType, .AttendenceType)
                    ClientScript.RegisterStartupScript(Me.GetType, "RefreshGrid", "parent.RefreshGrid();", True)
                End If
            End With

        End If
    End Sub

    Protected Sub CVS_CheckTimeDuration_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles CVS_CheckTimeDuration.ServerValidate
        Dim objHR_UserTimeHistory As New Portal.BLL.HR.HR_UserTimeHistory
        Dim dtAttendence As New System.Data.DataTable()
        If hdnMode.Value = "EditMode" Then
            dtAttendence = Portal.BLL.HR.HR_UserTimeHistory.HR_UserTimeHistoryCheckTimeDuration(CType(hdnTimeHistoryID.Value, Integer), Me.ddlUsers.Value, CDate(txtDate.Text))
        ElseIf hdnMode.Value = "NewMode" Then
            dtAttendence = Portal.BLL.HR.HR_UserTimeHistory.HR_UserTimeHistoryCheckTimeDuration(0, Me.ddlUsers.Value, CDate(txtDate.Text))
        End If

        Dim punchouttime As String = txtPunchOutTime.Text
        If punchouttime = "" Then punchouttime = "11:59:59 PM"
        Dim punchoutDateTime = CType(txtDate.Text & " " & punchouttime, DateTime)
        If Portal.BLL.Enumeration.TeamType.Support_Night = hdnTeamID.Value AndAlso _
                            CType(txtDate.Text & " " & txtPunchInTime.Text, DateTime) > CType(txtDate.Text & " " & txtPunchOutTime.Text, DateTime) Then
            punchoutDateTime = DateTime.Parse(CDate(txtDate.Text).AddDays(1) & " " & txtPunchOutTime.Text)
        End If
        args.IsValid = CheckTimeSlot(dtAttendence, CType(txtDate.Text & " " & txtPunchInTime.Text, DateTime), punchoutDateTime)
    End Sub

    Private Function CheckTimeSlot(ByVal dtAttendence As System.Data.DataTable, _
                                   ByVal DesiredTimeIn As DateTime, _
                                   ByVal DesiredTimeOut As DateTime) As Boolean
        Dim IsValidSlot As Boolean = True
        Dim PunchInTime As DateTime = DateTime.MinValue
        Dim PunchOutTime As DateTime = DateTime.MaxValue
        For Each drRows As System.Data.DataRow In dtAttendence.Rows
            PunchInTime = DateTime.MinValue
            PunchOutTime = DateTime.MaxValue
            PunchInTime = drRows("PunchInTime")
            PunchOutTime = drRows("PunchOutTime")

            If PunchInTime <> "12:00:00 AM" Then
                If PunchInTime > DesiredTimeIn And PunchInTime >= DesiredTimeOut _
            Or PunchOutTime <= DesiredTimeIn And PunchOutTime < DesiredTimeOut Then
                    IsValidSlot = True
                Else
                    CVS_CheckTimeDuration.ErrorMessage = "The time must not be beweeen " & PunchInTime.ToString("dd MMM hh:mm tt") & " and<br>" & PunchOutTime.ToString("dd MMM hh:mm tt")
                    IsValidSlot = False
                    Exit For
                End If
            End If
        Next
        Return IsValidSlot
    End Function

    Protected Sub ddlUsers_SelectedIndexChanged(ByVal o As Object, ByVal e As Telerik.WebControls.RadComboBoxSelectedIndexChangedEventArgs) Handles ddlUsers.SelectedIndexChanged
        SetTimeTeam()
        Me.hdnUserSelected.Value = Me.ddlUsers.Value
    End Sub
    Private Sub SetTimeTeam()
        Dim colHR_Users As New Portal.BLL.Users
        Dim userid = 0
        If ddlUsers.SelectedValue <> "" Then
            userid = ddlUsers.SelectedValue
        ElseIf ddlUsers.Value <> "" Then
            userid = ddlUsers.Value
        End If
        'CV_txtDate.Visible = True
        colHR_Users = Portal.BLL.HR.HR_UserTimeHistory.HR_GetTimeZoneOffSetByUserID(userid)
        If colHR_Users.TimeZoneID <> Nothing Then
            hdnTeamID.Value = colHR_Users.TeamID
            hdnTimeZoneOffSet.Value = colHR_Users.TimeZoneID
            Dim hours As Integer = hdnTimeZoneOffSet.Value - ConfigurationManager.AppSettings("ServerTimeZone")
            If (hdnTeamID.Value = Portal.BLL.Enumeration.TeamType.Support_Night) Then
                Dim longhour As Long = hours + 24
                CV_txtDate.ValueToCompare = DateTime.Now.Date.AddHours(longhour).ToShortDateString()
                CV_txtDate.ToolTip = DateTime.Now.Date.AddHours(longhour).ToShortDateString()
            Else
                CV_txtDate.ToolTip = DateTime.Now
                CV_txtDate.ToolTip = DateTime.Now.Date
                CV_txtDate.ValueToCompare = DateTime.Now.AddHours(hours).ToShortDateString()
                CV_txtDate.ToolTip = DateTime.Now.AddHours(hours)
            End If

        End If
    End Sub

End Class
