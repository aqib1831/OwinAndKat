
Partial Class HR_AddUserOfficeTimingProfiles
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Page.IsPostBack = False Then
            PapulateHours()
            lrtlDate.Text = DateTime.Now.ToString("dddd, MMMM d") & "<sup>" & Functions.GetSuperScript(DateTime.Now.Day) & "</sup>" & " " & DateTime.Now.Year
            If Not String.IsNullOrEmpty(Request.QueryString("ProfileID")) Then
                Me.hdnProfileID.Value = Request.QueryString("ProfileID")
                loadProfile()
            End If
        End If
    End Sub
    Private Sub loadProfile()
        Dim objUserOfficeTimingProfiles As New Portal.BLL.HR.UserOfficeTimingProfiles()
        Dim dtProfiles As New System.Data.DataTable
        objUserOfficeTimingProfiles.ID = Me.hdnProfileID.Value
        dtProfiles = Portal.BLL.HR.UserOfficeTimingProfiles.OfficeTimingProfileGetByID(objUserOfficeTimingProfiles)

        If dtProfiles Is Nothing = False Then
            If dtProfiles.Rows.Count > 0 Then
                Me.txtProfileName.Text = dtProfiles.Rows(0)("Name")
                Me.ddlShiftStartRelaxtionMinutes.SelectedValue = IIf(dtProfiles.Rows(0)("GraceStartTime") <= 9, "0" & dtProfiles.Rows(0)("GraceStartTime").ToString(), dtProfiles.Rows(0)("GraceStartTime"))
                Me.ddlShiftEndTimeRelaxationMinutes.SelectedValue = IIf(dtProfiles.Rows(0)("GraceEndTime") <= 9, "0" & dtProfiles.Rows(0)("GraceEndTime").ToString(), dtProfiles.Rows(0)("GraceEndTime"))
                Me.ddlBreakStartRelaxtionMinutes.SelectedValue = IIf(dtProfiles.Rows(0)("BreakGraceTimeStart") = 0, "0" & dtProfiles.Rows(0)("BreakGraceTimeStart"), dtProfiles.Rows(0)("BreakGraceTimeStart"))
                Me.ddlBreakEndRelaxationMinutes.SelectedValue = IIf(dtProfiles.Rows(0)("BreakGraceTimeEnd") <= 9, "0" & dtProfiles.Rows(0)("BreakGraceTimeEnd"), dtProfiles.Rows(0)("BreakGraceTimeEnd"))
                Me.ddlSaturdayStartTimeRelaxation.SelectedValue = IIf(dtProfiles.Rows(0)("SaturdayGraceStartTime") <= 9, "0" & dtProfiles.Rows(0)("SaturdayGraceStartTime"), dtProfiles.Rows(0)("SaturdayGraceStartTime"))
                Me.ddlSaturdayEndTimeRelaxtion.SelectedValue = IIf(dtProfiles.Rows(0)("SaturdayGraceEndTime") <= 9, "0" & dtProfiles.Rows(0)("SaturdayGraceEndTime"), dtProfiles.Rows(0)("SaturdayGraceEndTime"))
                Me.rbtnListStatus.SelectedValue = dtProfiles.Rows(0)("IsActive")

                Me.ddlShiftStartHours.SelectedValue = IIf(DateTime.Parse(dtProfiles.Rows(0)("StartDateTime")).Hour <= 9, DateTime.Parse(dtProfiles.Rows(0)("StartDateTime")).Hour.ToString(), DateTime.Parse(dtProfiles.Rows(0)("StartDateTime")).Hour)
                Me.ddlShiftStartMinutes.SelectedValue = IIf(DateTime.Parse(dtProfiles.Rows(0)("StartDateTime")).Minute <= 9, "0" & DateTime.Parse(dtProfiles.Rows(0)("StartDateTime")).Minute.ToString(), DateTime.Parse(dtProfiles.Rows(0)("StartDateTime")).Minute)
                Me.ddlShiftEndTimeHours.SelectedValue = IIf(DateTime.Parse(dtProfiles.Rows(0)("EndDateTime")).Hour <= 9, DateTime.Parse(dtProfiles.Rows(0)("EndDateTime")).Hour.ToString(), DateTime.Parse(dtProfiles.Rows(0)("EndDateTime")).Hour)
                Me.ddlShiftEndTimeMinutes.SelectedValue = IIf(DateTime.Parse(dtProfiles.Rows(0)("EndDateTime")).Minute <= 9, "0" & DateTime.Parse(dtProfiles.Rows(0)("EndDateTime")).Minute.ToString(), DateTime.Parse(dtProfiles.Rows(0)("EndDateTime")).Minute)

                Me.ddlBreakStartHours.SelectedValue = IIf(DateTime.Parse(dtProfiles.Rows(0)("BreakStartTime")).Hour <= 9, DateTime.Parse(dtProfiles.Rows(0)("BreakStartTime")).Hour.ToString(), DateTime.Parse(dtProfiles.Rows(0)("BreakStartTime")).Hour)
                Me.ddlBreakStartMinutes.SelectedValue = IIf(DateTime.Parse(dtProfiles.Rows(0)("BreakStartTime")).Minute <= 9, "0" & DateTime.Parse(dtProfiles.Rows(0)("BreakStartTime")).Minute.ToString(), DateTime.Parse(dtProfiles.Rows(0)("BreakStartTime")).Minute)
                Me.ddlBreakEndHours.SelectedValue = IIf(DateTime.Parse(dtProfiles.Rows(0)("BreakEndTime")).Hour <= 9, DateTime.Parse(dtProfiles.Rows(0)("BreakEndTime")).Hour.ToString(), DateTime.Parse(dtProfiles.Rows(0)("BreakEndTime")).Hour)
                Me.ddlBreakEndminutes.SelectedValue = IIf(DateTime.Parse(dtProfiles.Rows(0)("BreakEndTime")).Minute <= 9, "0" & DateTime.Parse(dtProfiles.Rows(0)("BreakEndTime")).Minute.ToString(), DateTime.Parse(dtProfiles.Rows(0)("BreakEndTime")).Minute)


                Me.ddlSaturdayStartTimeHours.SelectedValue = IIf(DateTime.Parse(dtProfiles.Rows(0)("SaturdayOfficeStartTime")).Hour <= 9, DateTime.Parse(dtProfiles.Rows(0)("SaturdayOfficeStartTime")).Hour.ToString(), DateTime.Parse(dtProfiles.Rows(0)("SaturdayOfficeStartTime")).Hour)
                Me.ddlSaturdayStartTimeMinutes.SelectedValue = IIf(DateTime.Parse(dtProfiles.Rows(0)("SaturdayOfficeStartTime")).Minute <= 9, "0" & DateTime.Parse(dtProfiles.Rows(0)("SaturdayOfficeStartTime")).Minute.ToString(), DateTime.Parse(dtProfiles.Rows(0)("SaturdayOfficeStartTime")).Minute)
                Me.ddlSaturdayEndTimeHours.SelectedValue = IIf(DateTime.Parse(dtProfiles.Rows(0)("SaturdayOfficeEndTime")).Hour <= 9, DateTime.Parse(dtProfiles.Rows(0)("SaturdayOfficeEndTime")).Hour.ToString(), DateTime.Parse(dtProfiles.Rows(0)("SaturdayOfficeEndTime")).Hour)
                Me.ddlSaturdayEndTimeMinutes.SelectedValue = IIf(DateTime.Parse(dtProfiles.Rows(0)("SaturdayOfficeEndTime")).Minute <= 9, "0" & DateTime.Parse(dtProfiles.Rows(0)("SaturdayOfficeEndTime")).Minute.ToString(), DateTime.Parse(dtProfiles.Rows(0)("SaturdayOfficeEndTime")).Minute)
            End If
        End If
    End Sub

    Private Sub PapulateHours()
        Dim hour As Integer = 1
        Dim StrHour As String = String.Empty
        Dim StrHourCaption As String = String.Empty
        While hour <= 23
            StrHour = hour
            If hour <= 9 Then
                StrHour = hour.ToString()
            End If

            If hour < 12 Then
                StrHourCaption = "AM"
            Else
                StrHourCaption = "PM"
                If hour > 12 Then
                    StrHour = CInt(StrHour) - 12
                End If
            End If

            ddlShiftStartHours.Items.Add(New ListItem(StrHour & " " & StrHourCaption, hour))
            ddlShiftEndTimeHours.Items.Add(New ListItem(StrHour & " " & StrHourCaption, hour))
            ddlBreakStartHours.Items.Add(New ListItem(StrHour & " " & StrHourCaption, hour))
            ddlBreakEndHours.Items.Add(New ListItem(StrHour & " " & StrHourCaption, hour))
            ddlSaturdayStartTimeHours.Items.Add(New ListItem(StrHour & " " & StrHourCaption, hour))
            ddlSaturdayEndTimeHours.Items.Add(New ListItem(StrHour & " " & StrHourCaption, hour))
            hour = hour + 1
        End While
        ddlShiftStartHours.SelectedValue = 9
        ddlShiftEndTimeHours.SelectedValue = 18
        ddlBreakStartHours.SelectedValue = 13
        ddlBreakEndHours.SelectedValue = 14
        ddlSaturdayStartTimeHours.SelectedValue = 9
        ddlSaturdayEndTimeHours.SelectedValue = 18

    End Sub

    Private Sub PapulateMinutes()
        Dim Minutes As Integer = 1
        Dim StrMinutes As String = String.Empty
        While Minutes <= 60
            StrMinutes = Minutes
            If Minutes <= 9 Then
                StrMinutes = "0" & Minutes.ToString()
            End If

            Minutes = Minutes + 1
        End While
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        Dim objUserOfficeTimingProfiles As New Portal.BLL.HR.UserOfficeTimingProfiles()
        Dim DefaultDate As DateTime = DateTime.Parse("1/1/1900")
        objUserOfficeTimingProfiles.Name = Me.txtProfileName.Text
        objUserOfficeTimingProfiles.GraceStartTime = Me.ddlShiftStartRelaxtionMinutes.SelectedValue
        objUserOfficeTimingProfiles.GraceEndTime = Me.ddlShiftEndTimeRelaxationMinutes.SelectedValue
        objUserOfficeTimingProfiles.BreakGraceTimeStart = Me.ddlBreakStartRelaxtionMinutes.SelectedValue
        objUserOfficeTimingProfiles.BreakGraceTimeEnd = Me.ddlBreakEndRelaxationMinutes.SelectedValue
        objUserOfficeTimingProfiles.SaturdayGraceStartTime = Me.ddlSaturdayStartTimeRelaxation.SelectedValue
        objUserOfficeTimingProfiles.SaturdayGraceEndTime = Me.ddlSaturdayEndTimeRelaxtion.SelectedValue
        objUserOfficeTimingProfiles.StartDateTime = DateTime.Parse("1/1/1900 " & Me.ddlShiftStartHours.SelectedValue & ":" & Me.ddlShiftStartMinutes.SelectedValue)
        objUserOfficeTimingProfiles.EndDateTime = DateTime.Parse("1/1/1900 " & Me.ddlShiftEndTimeHours.SelectedValue & ":" & Me.ddlShiftEndTimeMinutes.SelectedValue)
        objUserOfficeTimingProfiles.BreakStartTime = DateTime.Parse("1/1/1900 " & Me.ddlBreakStartHours.SelectedValue & ":" & Me.ddlBreakStartMinutes.SelectedValue)
        objUserOfficeTimingProfiles.BreakEndTime = DateTime.Parse("1/1/1900 " & Me.ddlBreakEndHours.SelectedValue & ":" & Me.ddlBreakEndminutes.SelectedValue)
        objUserOfficeTimingProfiles.SaturdayOfficeStartTime = DateTime.Parse("1/1/1900 " & Me.ddlSaturdayStartTimeHours.SelectedValue & ":" & Me.ddlSaturdayStartTimeMinutes.SelectedValue)
        objUserOfficeTimingProfiles.SaturdayOfficeEndTime = DateTime.Parse("1/1/1900 " & Me.ddlSaturdayEndTimeHours.SelectedValue & ":" & Me.ddlSaturdayEndTimeMinutes.SelectedValue)
        objUserOfficeTimingProfiles.Deleted = False
        objUserOfficeTimingProfiles.IsActive = rbtnListStatus.SelectedValue

        If DateDiff(DateInterval.Hour, objUserOfficeTimingProfiles.StartDateTime, objUserOfficeTimingProfiles.EndDateTime) < 0 Then
            objUserOfficeTimingProfiles.EndDateTime = objUserOfficeTimingProfiles.EndDateTime.AddDays(1)
        End If

        If DateDiff(DateInterval.Hour, objUserOfficeTimingProfiles.BreakStartTime, objUserOfficeTimingProfiles.BreakEndTime) < 0 Then
            objUserOfficeTimingProfiles.BreakEndTime = objUserOfficeTimingProfiles.BreakEndTime.AddDays(1)
        End If

        If DateDiff(DateInterval.Hour, objUserOfficeTimingProfiles.SaturdayOfficeStartTime, objUserOfficeTimingProfiles.SaturdayOfficeEndTime) < 0 Then
            objUserOfficeTimingProfiles.SaturdayOfficeEndTime = objUserOfficeTimingProfiles.SaturdayOfficeEndTime.AddDays(1)
        End If
        If Not String.IsNullOrEmpty(Me.hdnProfileID.Value) Then
            objUserOfficeTimingProfiles.ID = Me.hdnProfileID.Value
            Portal.BLL.HR.UserOfficeTimingProfiles.UpdateOfficeTimingProfile(objUserOfficeTimingProfiles)
        Else
            Portal.BLL.HR.UserOfficeTimingProfiles.AddOfficeTimingProfile(objUserOfficeTimingProfiles)
        End If

        Response.Redirect("ViewAllUserOfficeTimmingProfiles.aspx")
    End Sub

End Class
