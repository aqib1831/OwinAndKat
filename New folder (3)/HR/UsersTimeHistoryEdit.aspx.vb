Imports System.Collections.Generic
Partial Class HR_UsersTimeHistoryEdit
    Inherits System.Web.UI.Page
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
        If Not IsPostBack And ddlUsers.IsCallBack = False Then
            SetTimeTeam()
        End If
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            'ddlUsers.Items.Insert(0, New Telerik.WebControls.RadComboBoxItem("Select...", 0))
            '' ddlUsers.Items.Insert(0, New Telerik.WebControls.RadComboBoxItem("Select...", 0))
            If String.IsNullOrEmpty(Request.QueryString("ID")) = False AndAlso IsNumeric(Request.QueryString("ID")) Then
                'EditMode'
                hdnMode.Value = "EditMode"
                LoadStores(Request.QueryString("UserID"))
                sPunchOut.Visible = True
                Me.ddlUsers.Enabled = False
                CVS_CheckTimeDuration.Enabled = True
                CV_CompareTime.Enabled = True
                Me.hdnTimeHistoryID.Value = Request.QueryString("ID")
                LoadUserTimeHistory()
                txtDate.Enabled = False
                'imgDDCalander.Attributes.Add("disabled", "true")
                RFV_DueDate.Enabled = False
                CV_txtDate.Enabled = False
            ElseIf String.IsNullOrEmpty(Request.QueryString("UserID")) = False AndAlso IsNumeric(Request.QueryString("UserID")) Then
                'NewMode'
                hdnMode.Value = "NewMode"
                MEV_MEE_txtPunchOutTime.Enabled = False
                CV_CompareTime.Enabled = False
                LoadStores("")
                'ddlUsers.Value = Request.QueryString("UserID")
                ddlUsers.FindItemByValue(Request.QueryString("UserID")).Selected = True
                Me.ddlUsers.Value = Request.QueryString("UserID")
            End If
        End If
    End Sub

    Private Sub LoadUserTimeHistory()
        Dim colHR_UserTimeHistory As New List(Of Portal.BLL.HR.HR_UserTimeHistory)
        colHR_UserTimeHistory = Portal.BLL.HR.HR_UserTimeHistory.HR_UserTimeHistoryGetByID(CType(hdnTimeHistoryID.Value, Integer))
        ddlUsers.DataBind()
        If colHR_UserTimeHistory.Count > 0 Then
            Me.ddlUsers.SelectedValue = colHR_UserTimeHistory.Item(0).UserID
            txtDate.Text = colHR_UserTimeHistory.Item(0).PunchInTime.ToShortDateString()
            txtPunchInTime.Text = String.Format("{0:hh:mm:ss tt}", colHR_UserTimeHistory.Item(0).PunchInTime)
            txtPunchOutTime.Text = IIf(colHR_UserTimeHistory.Item(0).PunchOutTime = "1/1/1900", "", String.Format("{0:hh:mm tt}", colHR_UserTimeHistory.Item(0).PunchOutTime))
            hdnPunchOutTime.Value = IIf(colHR_UserTimeHistory.Item(0).PunchOutTime = "1/1/1900", "", String.Format("{0:hh:mm tt}", colHR_UserTimeHistory.Item(0).PunchOutTime))
            txtNotes.Text = colHR_UserTimeHistory.Item(0).LastUpdatedNotes
            hdnPreForcePO.Value = colHR_UserTimeHistory.Item(0).ForcedPunchOut
            Me.ddlAttendenceRecordTypes.SelectedValue = colHR_UserTimeHistory.Item(0).AttendenceType
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
                If hdnMode.Value = "EditMode" Then
                    .ID = CType(hdnTimeHistoryID.Value, Integer)
                    '.UserID = Nothing
                    .PunchInTime = DateTime.Parse(txtDate.Text & " " & txtPunchInTime.Text)
                    .PunchOutTime = DateTime.Parse(txtDate.Text & " " & txtPunchOutTime.Text)
                    If Portal.BLL.Enumeration.TeamType.Support_Night = hdnTeamID.Value AndAlso _
                            CType(txtDate.Text & " " & txtPunchInTime.Text, DateTime) > CType(txtDate.Text & " " & txtPunchOutTime.Text, DateTime) Then
                        .PunchOutTime = DateTime.Parse(CDate(txtDate.Text).AddDays(1) & " " & txtPunchOutTime.Text)
                    End If

                    '.LastAccessTime 
                    If hdnPreForcePO.Value = True Then
                        .ForcedPunchOut = True
                    ElseIf hdnPunchOutTime.Value = "" Then
                        .ForcedPunchOut = True
                    Else
                        .ForcedPunchOut = False
                    End If
                    '.Notes
                    '.Deleted
                    .LastUpdatedBy = Session("AdminID")
                    .LastUpdatedNotes = txtNotes.Text.Trim()
                    .CreationType = 1
                    .AttendenceType = ddlAttendenceRecordTypes.SelectedValue
                    .HR_UserTimeHistoryUpdate(.ID, .UserID, .PunchInTime, .PunchOutTime, .LastAccessTime, .ForcedPunchOut, .Notes, .Deleted, .LastUpdatedBy, .LastUpdatedNotes, .CreationType, .AttendenceType)
                    ClientScript.RegisterStartupScript(Me.GetType, "RefreshGrid", "parent.RefreshGrid();", True)
                ElseIf hdnMode.Value = "NewMode" Then
                    .ID = 0
                    '.UserID = ddlUsers.SelectedValue
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
                    '.Notes
                    .Deleted = False
                    .LastUpdatedBy = Session("AdminID")
                    .LastUpdatedNotes = txtNotes.Text.Trim()
                    .CreationType = 2
                    .AttendenceType = ddlAttendenceRecordTypes.SelectedValue
                    .HR_UserTimeHistoryAdd(.ID, .UserID, .PunchInTime, .PunchOutTime, .LastAccessTime, .ForcedPunchOut, .Notes, .Deleted, .LastUpdatedBy, .LastUpdatedNotes, .CreationType, .AttendenceType)
                    'ClientScript.RegisterStartupScript(Me.GetType, "setUserCombo", "parent.setUserCombo('" & ddlUsers.SelectedValue & "','" & ddlUsers.SelectedItem.Text.ToString() & "');", True)
                    ClientScript.RegisterStartupScript(Me.GetType, "setUserCombo", "parent.setUserCombo('" & ddlUsers.Value & "','" & ddlUsers.Text.ToString() & "');", True)
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
    End Sub
    Private Sub SetTimeTeam()
        Dim colHR_Users As New Portal.BLL.Users
        Dim userid = 0
        If ddlUsers.SelectedValue <> "" Then
            userid = ddlUsers.SelectedValue
        ElseIf ddlUsers.Value <> "" Then
            userid = ddlUsers.Value
        End If
        colHR_Users = Portal.BLL.HR.HR_UserTimeHistory.HR_GetTimeZoneOffSetByUserID(userid)
        If colHR_Users.TimeZoneID <> Nothing Then
            hdnTeamID.Value = colHR_Users.TeamID
            hdnTimeZoneOffSet.Value = colHR_Users.TimeZoneID
            Dim hours As Integer = hdnTimeZoneOffSet.Value - ConfigurationManager.AppSettings("ServerTimeZone")
	    'CV_txtDate.ToolTip = hours 
            If (hdnTeamID.Value = Portal.BLL.Enumeration.TeamType.Support_Night) Then
                Dim longhour As Long = hours + 24
                CV_txtDate.ValueToCompare = DateTime.Now.Date.AddHours(longhour).ToShortDateString()
                CV_txtDate.ToolTip = DateTime.Now.AddHours(longhour).ToShortDateString()
            Else
                CV_txtDate.ValueToCompare = DateTime.Now.AddHours(hours).ToShortDateString()
                CV_txtDate.ToolTip = DateTime.Now.AddHours(hours).ToShortDateString()
            End If
            
        End If
    End Sub
End Class
