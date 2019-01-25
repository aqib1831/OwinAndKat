Partial Class TempHR_EmployeeTimeHistoryInDetail_Printable
    Inherits System.Web.UI.Page
    Dim CurrentDate As DateTime = DateTime.MinValue
    Dim StrComments As String = String.Empty
    Dim WorkingDayMinutes As Integer = 0
    Dim SumTotalMinutes As Integer = 0
    Dim TotalUsers As Integer = 0
    Dim LateArrivalFlagCurrentDay As Integer = 0
    Dim EarlyDepartureCurrentDay As Integer = 0
    Dim LateSittingCurrentDay As Integer = 0
    Dim TotalLateArrivals As Integer = 0
    Dim TotalEarlyDepartures As Integer = 0
    Dim TotalLateSittings As Integer = 0
    Dim TotalLeaves As Integer = 0
    Dim TotalShortLeaves As Integer = 0
    Dim TotalShortLeavesMinutes As Integer = 0
    Dim PageNo As Integer = 1
    Dim RecordCurrentPage As Integer = 0
    Dim MaxRecordsPerPage As Integer = 8
    Dim PunchInCommentIndex As Integer = 0
    Dim PunchOutCommentIndex As Integer = 0
    Dim CommentIndex As Integer = 1
    Dim CurrentUser As Integer = 0

    Enum OffDaysTypes As Integer
        Leave = 1
        Absent = 2
        OfficialLeave = 3
        ShortLeave = 4
        OffSaturday = 5
    End Enum

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Me.hdnStartDate.Value = DateTime.Parse(Request.QueryString("StartDate"))
        'Me.hdnEndDate.Value = DateTime.Parse(Request.QueryString("EndDate"))
        'hdnDepartmentID.Value = Request.QueryString("DepartmentID")
        'hdnEmployeeID.Value = Request.QueryString("UserID")
        'hdnTeamID.Value = Request.QueryString("TeamID")
        'hdnStatus.Value = Request.QueryString("Status")

        TotalLeaves = 0
        TotalShortLeaves = 0
        TotalShortLeavesMinutes = 0

        Me.hdnStartDate.Value = DateTime.Parse("05/01/2011")
        Me.hdnEndDate.Value = DateTime.Parse("05/31/2011")
        hdnDepartmentID.Value = 0
        hdnEmployeeID.Value = 0
        hdnTeamID.Value = 0
        hdnStatus.Value = 0

        PunchInCommentIndex = 0
        PunchOutCommentIndex = 0
        CommentIndex = 1
    End Sub

    Protected Sub rptUsers_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptUsers.ItemDataBound
        TotalUsers = DirectCast(DirectCast(DirectCast(DirectCast(e.Item, System.Web.UI.WebControls.RepeaterItem).DataItem, System.Object), System.Data.DataRowView).Row, System.Data.DataRow).Table.Rows.Count
        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            WorkingDayMinutes = 0
            SumTotalMinutes = 0
            PunchInCommentIndex = 0
            PunchOutCommentIndex = 0
            PageNo = 1
            RecordCurrentPage = 0
            LateArrivalFlagCurrentDay = 0
            EarlyDepartureCurrentDay = 0
            LateSittingCurrentDay = 0
            CurrentDate = DateTime.MinValue
            TotalLateArrivals = 0
            TotalEarlyDepartures = 0
            TotalLateSittings = 0
            TotalLeaves = 0
            TotalShortLeaves = 0
            TotalShortLeavesMinutes = 0
            CommentIndex = 1
            StrComments = String.Empty
            CType(e.Item.FindControl("ltrlStartDate"), Literal).Text = DateTime.Parse(Me.hdnStartDate.Value).ToString("MM/dd/yyyy")
            CType(e.Item.FindControl("ltrlEndDate"), Literal).Text = DateTime.Parse(Me.hdnEndDate.Value).ToString("MM/dd/yyyy")
            CurrentUser = CurrentUser + 1
            If CurrentUser = TotalUsers Then
                CType(e.Item.FindControl("dvHeader"), HtmlControl).Style.Add("page-break-after", "auto")
            End If
        End If
    End Sub

    Protected Sub rptAttendence_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs)
        StrComments = String.Empty
        WorkingDayMinutes = 0
        LateArrivalFlagCurrentDay = 0
        EarlyDepartureCurrentDay = 0
        LateSittingCurrentDay = 0
        PunchInCommentIndex = 0
        PunchOutCommentIndex = 0
        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            If e.Item.DataItem("PunchInDate") <> CurrentDate Then
                WorkingDayMinutes = 0
                CommentIndex = 1
                If PageNo = 1 Then
                    MaxRecordsPerPage = 20
                Else
                    MaxRecordsPerPage = 11
                End If
                If RecordCurrentPage > MaxRecordsPerPage Then
                    CType(e.Item.FindControl("trItemHeader"), HtmlTableRow).Style.Add("page-break-before", "always")
                    e.Item.FindControl("trItemHeader").Visible = True
                    RecordCurrentPage = 0
                    PageNo = PageNo + 1
                End If

                CType(e.Item.FindControl("rptPunchIns"), Repeater).DataSource = ExtractRowsForDataTable(DirectCast(DirectCast(DirectCast(DirectCast(e.Item, System.Web.UI.WebControls.RepeaterItem).DataItem, System.Object), System.Data.DataRowView).Row, System.Data.DataRow).Table, e.Item.DataItem("PunchInDate"), e.Item.DataItem("UserID"))
                CType(e.Item.FindControl("rptPunchIns"), Repeater).DataBind()
                e.Item.FindControl("trRptPunchInRecord").Visible = True
                RecordCurrentPage = RecordCurrentPage + 1
                CType(e.Item.FindControl("ltrlComments"), Literal).Text = StrComments
                CType(e.Item.FindControl("ltrlCurrentWorkingDay"), Literal).Text = Me.GetTotalHours(WorkingDayMinutes).ToString()
                LateArrivalFlagCurrentDay = IIf(e.Item.DataItem("IsLateArrival") Is DBNull.Value = False, IIf(e.Item.DataItem("IsLateArrival"), 1, 0), 0)
                EarlyDepartureCurrentDay = IIf(e.Item.DataItem("HasEarlyDeparture") Is DBNull.Value = False, IIf(e.Item.DataItem("HasEarlyDeparture"), 1, 0), 0)
                LateSittingCurrentDay = IIf(e.Item.DataItem("HasLateSitting") Is DBNull.Value = False, IIf(e.Item.DataItem("HasLateSitting"), 1, 0), 0)
                CType(e.Item.FindControl("ltrlCurrentFlags"), Literal).Text = "LA = " & LateArrivalFlagCurrentDay.ToString() & ", ED = " & EarlyDepartureCurrentDay.ToString() & ", LS = " & LateSittingCurrentDay.ToString()
            End If
            CurrentDate = e.Item.DataItem("PunchInDate")
            SumTotalMinutes = SumTotalMinutes + WorkingDayMinutes
            TotalLateArrivals = TotalLateArrivals + LateArrivalFlagCurrentDay
            TotalEarlyDepartures = TotalEarlyDepartures + EarlyDepartureCurrentDay
            TotalLateSittings = TotalLateSittings + LateSittingCurrentDay
            TotalShortLeaves = IIf(e.Item.DataItem("AttendenceType") = 2, TotalShortLeaves + 1, TotalShortLeaves)
            If e.Item.DataItem("AttendenceType") = 2 Then
                If e.Item.DataItem("PunchOutTime") Is DBNull.Value = False Then
                    TotalShortLeavesMinutes = TotalShortLeavesMinutes + DateDiff(DateInterval.Minute, e.Item.DataItem("PunchInTime"), e.Item.DataItem("PunchOutTime"))
                End If
            End If
        ElseIf e.Item.ItemType = ListItemType.Footer Then
            CType(e.Item.FindControl("ltrlTotalHours"), Literal).Text = Me.GetTotalHours(SumTotalMinutes).ToString()
            'CType(e.Item.FindControl("ltrlTotalFlags"), Literal).Text = "Total Absenties = " & TotalLeaves & " <br />Short Leaves= " & TotalShortLeaves & ", LA = " & TotalLateArrivals.ToString() & ", ED = " & TotalEarlyDepartures.ToString() & ", LS = " & TotalLateSittings.ToString()

            CType(e.Item.FindControl("ltrlTotalFlags"), Literal).Text = ""
            CType(e.Item.FindControl("ltrlTotalFlags"), Literal).Text = "<div>Total Absentees - <span style='font-weight:normal;'>" & TotalLeaves & "</span></div>"
            CType(e.Item.FindControl("ltrlTotalFlags"), Literal).Text &= "<div>Total Short Leaves - <span style='font-weight:normal;'>" & TotalShortLeaves & "</span><span style='font-weight:normal;'>&nbsp;(" & Me.GetTotalHours(Me.TotalShortLeavesMinutes).ToString() & "/" & Me.GetTotalHours(SumTotalMinutes).ToString() & ")</span></div>"
            CType(e.Item.FindControl("ltrlTotalFlags"), Literal).Text &= "<div>Total Late Arrivals - <span style='font-weight:normal;'>" & TotalLateArrivals & "</span></div>"
            CType(e.Item.FindControl("ltrlTotalFlags"), Literal).Text &= "<div>Total Early Departures - <span style='font-weight:normal;'>" & TotalEarlyDepartures & "</span></div>"
            CType(e.Item.FindControl("ltrlTotalFlags"), Literal).Text &= "<div>Total Late Sittings - <span style='font-weight:normal;'>" & TotalLateSittings & "</span></div>"
        End If
    End Sub

    Protected Sub rptPunchIns_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs)
        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            If e.Item.DataItem("PunchInTime") Is DBNull.Value = False Then
                CType(e.Item.FindControl("ltrlPunchIn"), Literal).Text = DateTime.Parse(e.Item.DataItem("PunchInTime")).ToString("hh:mm tt")
                If e.Item.DataItem("PunchOutTime") Is DBNull.Value = False Then
                    CType(e.Item.FindControl("ltrlPunchout"), Literal).Text = DateTime.Parse(e.Item.DataItem("PunchOutTime")).ToString("hh:mm tt")
                    WorkingDayMinutes = WorkingDayMinutes + DateDiff(DateInterval.Minute, e.Item.DataItem("PunchInTime"), e.Item.DataItem("PunchOutTime"))
                Else
                    CType(e.Item.FindControl("ltrlPunchout"), Literal).Text = ""
                End If
                If e.Item.DataItem("LateArrivalNotes") Is DBNull.Value = False Then
                    If Not String.IsNullOrEmpty(e.Item.DataItem("LateArrivalNotes")) Then
                        PunchInCommentIndex = PunchInCommentIndex + 1
                        PunchOutCommentIndex = PunchOutCommentIndex + 1
                        CType(e.Item.FindControl("ltrlPunchIn"), Literal).Text = CType(e.Item.FindControl("ltrlPunchIn"), Literal).Text & "<span style='font-size:8px;font-weight:bold; padding-bottom-3px;'>" & CommentIndex.ToString() & "</span>"
                        StrComments = StrComments & "<span style='font-size:8px;font-weight:bold;padding-bottom-3px;'>" & CommentIndex.ToString() & "</span>" & e.Item.DataItem("LateArrivalNotes").ToString().Replace(vbCrLf, " ") & "&nbsp;"
                        CommentIndex = CommentIndex + 1
                    End If
                End If
                If e.Item.DataItem("EarlyDepartureNotes") Is DBNull.Value = False Then
                    If Not String.IsNullOrEmpty(e.Item.DataItem("EarlyDepartureNotes")) Then
                        PunchOutCommentIndex = PunchOutCommentIndex + 1
                        CType(e.Item.FindControl("ltrlPunchOut"), Literal).Text = CType(e.Item.FindControl("ltrlPunchOut"), Literal).Text & "<span style='font-size:8px;font-weight:bold;padding-bottom-3px;'>" & CommentIndex.ToString() & "</span>"
                        StrComments = StrComments & "<span style='font-size:8px;font-weight:bold;padding-bottom-3px;'>" & CommentIndex.ToString() & "</span>" & e.Item.DataItem("EarlyDepartureNotes").ToString().Replace(vbCrLf, " ") & "&nbsp;"
                        CommentIndex = CommentIndex + 1
                    End If
                End If
                If e.Item.DataItem("LateSittingNotes") Is DBNull.Value = False Then
                    If Not String.IsNullOrEmpty(e.Item.DataItem("LateSittingNotes")) Then
                        PunchOutCommentIndex = PunchOutCommentIndex + 1
                        CType(e.Item.FindControl("ltrlPunchOut"), Literal).Text = CType(e.Item.FindControl("ltrlPunchOut"), Literal).Text & "<span style='font-size:8px;font-weight:bold;padding-bottom-3px;'>" & CommentIndex.ToString() & "</span>"
                        StrComments = StrComments & "<span style='font-size:8px;font-weight:bold;padding-bottom-3px;'>" & CommentIndex.ToString() & "</span>" & e.Item.DataItem("LateSittingNotes").ToString().Replace(vbCrLf, " ") & "&nbsp;"
                        CommentIndex = CommentIndex + 1
                    End If
                End If
            Else
                e.Item.FindControl("tdPunchCellContainer").Visible = False
                e.Item.FindControl("tdAbsentContainer").Visible = True
                CType(e.Item.FindControl("ltrlAbsentNote"), Literal).Text = GetOffDaysHtml(e.Item.DataItem("OffDayType")).ToString()

            End If
        End If
    End Sub

    Private Function ExtractRowsForDataTable(ByVal dtContainer As System.Data.DataTable, _
                                             ByVal dtDate As DateTime, _
                                             ByVal UserID As Integer) As System.Data.DataTable

        Dim dtDataTable As New System.Data.DataTable()
        dtDataTable = dtContainer.Clone()
        Dim drRows() As System.Data.DataRow
        drRows = dtContainer.Select("PunchInDate = '" & dtDate.ToShortDateString() & "' and UserID =" & UserID)
        Dim counter As Integer = 0
        While counter < drRows.Length
            dtDataTable.ImportRow(drRows(counter))
            counter = counter + 1
        End While

        Return dtDataTable
    End Function

    Private Function GetOffDaysHtml(ByVal OffDayType As Integer) As StringBuilder
        Dim StrNote As String = ""
        Dim ColorCode As String = ""
        If OffDayType = OffDaysTypes.Absent Then
            StrNote = "ABSENT"
            ColorCode = "#EEF5FB"
            TotalLeaves = TotalLeaves + 1
        ElseIf OffDayType = OffDaysTypes.Leave Then
            StrNote = "Leave"
            ColorCode = "#EEF5FB"
        ElseIf OffDayType = OffDaysTypes.OfficialLeave Then
            StrNote = "OFFICAL-LEAVE"
            ColorCode = "#EEF5FB"
        ElseIf OffDayType = OffDaysTypes.ShortLeave Then

        ElseIf OffDayType = OffDaysTypes.OffSaturday Then
            StrNote = "OFF-SATURDAY"
            ColorCode = "#E9E4FB"
        End If

        Dim strReturnHtml As New StringBuilder
        REM strReturnHtml.Append("<div class='divOffDay' style='float: left; background-color:###COLOR####;border:solid 1px #D4DDE4; width:357px; height:40px;'><div style='text-align:center; padding-top:10px;'>###NOTE###</div></div>")
        strReturnHtml.Append("<div style='float: left; /*width:300px;*/width:160px; '><div style='text-align:center; padding-top:10px;'>###NOTE###</div></div>")

        strReturnHtml.Replace("###NOTE###", StrNote)
        strReturnHtml.Replace("###COLOR####", ColorCode)
        Return strReturnHtml
    End Function

    Private Function GetTotalHours(ByVal Minutes As Integer) As String
        Dim StrReturn As String = String.Empty
        Dim TotalHours As Integer = 0
        Dim TotalMinutes As Integer = 0
        TotalMinutes = Minutes Mod 60
        TotalHours = (Minutes - TotalMinutes) / 60
        If TotalHours < 9 Then
            StrReturn = "<span>"
        ElseIf TotalHours > 9 Then
            StrReturn = "<span>"
        Else
            StrReturn = "<span>"
        End If
        StrReturn = StrReturn & IIf(TotalHours < 10, "0" & TotalHours, TotalHours) & ":" & IIf(TotalMinutes < 10, "0" & TotalMinutes, TotalMinutes)
        StrReturn = StrReturn & "</span>"

        Return StrReturn
    End Function

End Class
