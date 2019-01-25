Partial Class HR_EmployeeTimeHistoryInDetail
    Inherits System.Web.UI.Page
    Private TimeHistoryRecordID As Integer = 0
    Private UserID As Integer = 0
    Private PrintingTimeInTimeOut As Integer = 0
    Private HeaderCaptionsPrinted As Boolean = False
    Private CurrentDate As DateTime = DateTime.MinValue
    Private TotalWorkingMinutes As Integer = 0
    Private WorkingMinutesEachDay As Integer = 0
    Private TotalLateArrivals As Integer = 0
    Private TotalEarlyDeparture As Integer = 0
    Private TotalLateSittings As Integer = 0
    Private arrUserTempDates As New System.Collections.ArrayList()
    Private StartDate As DateTime = DateTime.MinValue
    Private EndDate As DateTime = DateTime.Now
    Private TotalRows As Integer = 0
    Private CurrentRow As Integer = 0
    Private IsFirstPunchIn As Boolean = True
    Private arrPunchIns As New System.Collections.ArrayList()
    Private arrPunchOuts As New System.Collections.ArrayList()
    Private HasRenderedCellsContainer As Boolean = False
    Private ArrNotes As New System.Collections.ArrayList()
    Private ArrLateArrivalNotes As New System.Collections.ArrayList()
    Private ArrEarlyDepartureNotes As New System.Collections.ArrayList()
    Private ArrLateSittingNotes As New System.Collections.ArrayList()

    Private DefaultPunchOutTime As String = "06:00:00 PM"
    Private AnnualLeavesAllowed As Integer = 0
    Private AnnualLeavesTaken As Integer = 0
    Private AnnualLeavesBalance As Integer = 0
    Private CausalLeavesAllowed As Integer = 0
    Private CausalLeavesTaken As Integer = 0
    Private CausalLeavesBalance As Integer = 0
    Private IsLateArrival As Boolean = False
    Private HasEarlyDeparture As Boolean = False
    Private HasLateSitting As Boolean = False
    Private arrTeams As String()
    Private arrTeamsUnder As String()
    Private MinimumOfficeWorkingMinutes As Integer = 0
    Private NotesCounter As Integer = 0
    Private UpdatedByUser As String = String.Empty


    Enum OffDaysTypes As Integer
        Leave = 1
        Absent = 2
        OfficialLeave = 3
        ShortLeave = 4
        OffSaturday = 5
    End Enum
    Private Sub LoadEmployeeByDepartmentAndTeam(ByVal Search As String, _
                                                ByVal DepartmentID As Integer, _
                                                ByVal TeamID As Integer)
        Dim db As New DBAccess

        Dim dt As System.Data.DataTable
        If DepartmentID <> 0 Then
            db.AddParameter("@DepartmentID", DepartmentID)
        Else
            db.AddParameter("@DepartmentID", DBNull.Value)
        End If
        If TeamID <> 0 Then
            db.AddParameter("@TeamID", TeamID)
        Else
            db.AddParameter("@TeamID", DBNull.Value)
        End If

        If Not String.IsNullOrEmpty(Search) Then
            db.AddParameter("@Search", Search)
        Else
            db.AddParameter("@Search", DBNull.Value)
        End If

        ddlUsers.Items.Clear()
        dt = db.ExecuteDataTable("HR_AdminSearchByDepartmentAndTeam")
        ddlUsers.DataSource = dt
        ddlUsers.DataBind()
    End Sub

    Private Sub LoadEmployee(ByVal UserID As Integer, _
                             ByVal Search As String, _
                             ByVal IsAdmin As Integer)

        Dim db As New DBAccess()
        Dim dt As New System.Data.DataTable()
        If Not String.IsNullOrEmpty(Search) Then
            db.AddParameter("@Search", Search)
        Else
            db.AddParameter("@Search", DBNull.Value)
        End If
        db.AddParameter("@UserID", UserID)
        db.AddParameter("@IsAdmin", IsAdmin)
        dt = db.ExecuteDataTable("HR_SearchEmployee")
        ddlUsers.DataSource = dt
        ddlUsers.DataBind()

    End Sub

    Private Function AvailableDepartments() As System.Collections.ArrayList
        Dim Departments As New System.Collections.ArrayList
        Dim arrUserUniqueStr() As String
        For Each objradItem As Telerik.WebControls.RadComboBoxItem In ddlUsers.Items
            arrUserUniqueStr = Nothing
            arrUserUniqueStr = objradItem.Value.Split("&")
            If arrUserUniqueStr.Length = 3 Then
                If Not Departments.Contains(arrUserUniqueStr(1)) Then
                    Departments.Add(arrUserUniqueStr(1))
                End If
            End If
        Next
        Return Departments
    End Function


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Page.IsPostBack = False Then

            Me.hdnTimeZoneHoursDIFF.Value = Portal.BLL.HR.TimeZones.TimeZoneGetByID(CType(HttpContext.Current.Session("AdminCurrentobjUser"), Portal.BLL.Users).TimeZoneID)
            Me.hdnHasEditAccess.Value = "0"
            Me.hdnIsAdmin.Value = "0"
            CheckModuleAccess()
            CheckSubModuleAccess()
            SetTeamAndSupervisorInfo()
            FillTeamsInfoArrayList()
            LoadEmployee(CType(HttpContext.Current.Session("AdminCurrentobjUser"), Portal.BLL.Users).ID, String.Empty, Me.hdnIsAdmin.Value)
            If hdnHasEditAccess.Value = "1" Then
                Me.dvAddNewTimeRecord.Visible = True
            End If
            Dim UserRadValue As String = CInt(Session("AdminID")) & "&" & CType(HttpContext.Current.Session("AdminCurrentobjUser"), Portal.BLL.Users).DepartmentID & "&" & Me.hdnTeamID.Value
            ddlUsers.FindItemByValue(UserRadValue).Selected = True
            Me.hdnDefaultStartDate.Value = DateTime.Now.AddDays(-7).ToShortDateString()
            Me.ddlPeriod.SelectedValue = 8
            Me.hdnDefaultEndDate.Value = DateTime.Now.ToShortDateString()
            Me.hdnStartDate.Value = DateTime.Now.AddDays(-7).ToShortDateString()
            'Me.hdnEndDate.Value = DateTime.Now.AddHours(Me.hdnTimeZoneHoursDIFF.Value)
	    Me.hdnEndDate.Value = DateTime.Now.AddHours(9)
            hdnSessionID.Value = CType(HttpContext.Current.Session("AdminCurrentobjUser"), Portal.BLL.Users).ID
            If hdnIsAdmin.Value = "0" Then
                If Not arrTeamsUnder.Length = 0 Then
                    Me.ddlUsers.Enabled = False
                    Dim CounterTeamsUnder As Integer = 0

                    While CounterTeamsUnder < arrTeamsUnder.Length
                        If Not String.IsNullOrEmpty(arrTeamsUnder(CounterTeamsUnder)) Then
                            ddlUsers.FindItemByValue("0").Selected = True
                        End If
                        CounterTeamsUnder = CounterTeamsUnder + 1
                    End While
                End If
            End If
            Dim arrUserInfo() As String
            Dim UserID, DepartmentID, TeamID As Integer
            arrUserInfo = Me.ddlUsers.SelectedValue.Split("&")
            UserID = arrUserInfo(0)
            Me.hdnDefaultDepartmentID.Value = 0
            Me.hdnDefaultTeamID.Value = 0
            If arrUserInfo.Length = 3 Then
                DepartmentID = arrUserInfo(1)
                TeamID = arrUserInfo(2)
                Me.ddlTeams.SelectedValue = TeamID
                Me.ddlDeparments.SelectedValue = DepartmentID
                Me.hdnDefaultDepartmentID.Value = DepartmentID
                Me.hdnDefaultTeamID.Value = TeamID
            End If
            hdnSelectedUser.Value = UserID
        Else
            Dim arrUserInfo() As String
            Dim UserID, DepartmentID, TeamID As Integer
            arrUserInfo = Me.ddlUsers.SelectedValue.Split("&")
            If String.IsNullOrEmpty(Me.ddlUsers.SelectedValue) Then
                UserID = 0
            Else
                UserID = arrUserInfo(0)
            End If
            hdnSelectedUser.Value = UserID
        End If
        FillTeamsInfoArrayList()
    End Sub

    Private Sub SetTeamAndSupervisorInfo()
        hdnTeamID.Value = ""
        hdnTeamsUnder.Value = ""

        Dim dtGroupInfo As New System.Data.DataTable
        dtGroupInfo = Portal.BLL.Users.GetTeamInformation(CType(HttpContext.Current.Session("AdminCurrentobjUser"), Portal.BLL.Users).ID)
        If dtGroupInfo Is Nothing = False Then
            For Each dr As System.Data.DataRow In dtGroupInfo.Rows
                hdnTeamID.Value = dr("TeamID")
                hdnTeamsUnder.Value = hdnTeamsUnder.Value & IIf(dr("TeamUnder") Is DBNull.Value = False, dr("TeamUnder").ToString() & ",", "")
            Next
        End If
    End Sub


    Private Sub FillTeamsInfoArrayList()
        arrTeams = Me.hdnTeamID.Value.ToString().Split(",")
        Me.hdnTeamsUnder.Value = Me.hdnTeamsUnder.Value.TrimEnd(",")
        arrTeamsUnder = Me.hdnTeamsUnder.Value.ToString().Split(",")
    End Sub


    Private Sub CheckModuleAccess()
        Dim strcsv As String = Session("UsersModulesID")
        Dim ArrReportAdminsList() As String
        ArrReportAdminsList = System.Web.Configuration.WebConfigurationManager.AppSettings("HRTimeReportAdminUsers").ToString().Split(",")

        For Each strAdmin As String In ArrReportAdminsList
            If Not String.IsNullOrEmpty(strAdmin) Then
                If strAdmin = CType(HttpContext.Current.Session("AdminCurrentobjUser"), Portal.BLL.Users).ID Then
                    hdnIsAdmin.Value = "1"
                End If
            End If
        Next

        If strcsv <> Nothing AndAlso strcsv <> String.Empty Then
            Dim srtArray As String() = strcsv.Split(",")
            If srtArray.Length > 0 Then
                For i As Integer = 0 To srtArray.Length - 1
                    If srtArray(i) = Portal.BLL.Enumeration.Modules.Administration Then
                        hdnIsAdmin.Value = "1"
                    End If
                Next
            End If
        End If
    End Sub
    Private Sub CheckSubModuleAccess()
        Dim strcsv As String = Session("UsersSubModulesID")
        If strcsv <> Nothing AndAlso strcsv <> String.Empty Then
            Dim srtArray As String() = strcsv.Split(",")
            If srtArray.Length > 0 Then
                For i As Integer = 0 To srtArray.Length - 1
                    If srtArray(i) = Portal.BLL.Enumeration.SubModules.ManageTimeHistory Then
                        hdnHasEditAccess.Value = "1"
                    End If
                Next
            End If
        End If
    End Sub

    Protected Sub ddlDeparments_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlDeparments.DataBound
        Me.ddlDeparments.SelectedValue = CType(HttpContext.Current.Session("AdminCurrentobjUser"), Portal.BLL.Users).DepartmentID
        Dim AvailableDepartmentsList As New System.Collections.ArrayList()
        AvailableDepartmentsList = AvailableDepartments()

        Dim Counter As Integer = 0
        While Counter < ddlDeparments.Items.Count
            If Not AvailableDepartmentsList.Contains(ddlDeparments.Items(Counter).Value) Then
                If Not CType(HttpContext.Current.Session("AdminCurrentobjUser"), Portal.BLL.Users).DepartmentID = ddlDeparments.Items(Counter).Value Then
                    ddlDeparments.Items.Remove(ddlDeparments.Items.FindByValue(ddlDeparments.Items(Counter).Value))
                    Continue While
                End If
            End If
            Counter = Counter + 1
        End While
        If Me.hdnIsAdmin.Value = "1" Or Request("hdnIsAdmin") = "1" Then
            ddlDeparments.Items.Insert(0, New ListItem("Show All", 0))
        End If
    End Sub

    Protected Sub rptTimeHistoryMain_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptTimeHistoryMain.ItemDataBound
        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            TotalRows = DirectCast(DirectCast(DirectCast(DirectCast(DirectCast(DirectCast(e.Item, System.Web.UI.WebControls.RepeaterItem).DataItem, System.Object), System.Data.DataRowView).Row, System.Data.DataRow).Table, System.Data.DataTable).Rows, System.Data.DataRowCollection).Count

            If UserID = 0 And UserID <> e.Item.DataItem("UserID") Then REM Different User
                e.Item.FindControl("ltrldivContainerStart").Visible = True
                e.Item.FindControl("dvName").Visible = True
                e.Item.FindControl("dvCaptions").Visible = True
                e.Item.FindControl("dvDate").Visible = True
                e.Item.FindControl("dvInOutNote").Visible = True

                If e.Item.DataItem("PunchInTime") Is DBNull.Value Then
                    REM CType(e.Item.FindControl("ltrlOffDays"), Literal).Text = GetOffDaysHtml(arrUserTempDates, DateTime.Parse(e.Item.DataItem("PunchInDate")), e.Item.DataItem("OffSaturdayDate")).ToString()
                    CType(e.Item.FindControl("ltrlOffDays"), Literal).Text = GetOffDaysHtml(DateTime.Parse(e.Item.DataItem("PunchInDate")), e.Item.DataItem("OffDayType")).ToString()
                    CType(e.Item.FindControl("ltrlOffDays"), Literal).Visible = True
                    WorkingMinutesEachDay = 0
                    TotalLateArrivals = 0
                    TotalEarlyDeparture = 0
                    TotalLateSittings = 0
                    arrPunchIns.Clear()
                    arrPunchOuts.Clear()
                    ArrNotes.Clear()
                    NotesCounter = 0
                    ArrLateArrivalNotes.Clear()
                    ArrEarlyDepartureNotes.Clear()
                    ArrLateSittingNotes.Clear()
                    ResetTimeHistoryFlag(False, False, False)
                Else
                    CType(e.Item.FindControl("ltrlTimeIn"), Literal).Text = FormatEditAttributes(DateTime.Parse(e.Item.DataItem("PunchInTime")).ToString("hh:mm"), e.Item.DataItem("PunchInTime"), e.Item.DataItem("PunchOutTime"), 1, e.Item.DataItem("TimeRecordID"), e.Item.DataItem("AttendenceType"), -1)
                    CType(e.Item.FindControl("ltrlTimeOffSet"), Literal).Text = FormatEditAttributes(DateTime.Parse(e.Item.DataItem("PunchInTime")).ToString("tt"), e.Item.DataItem("PunchInTime"), e.Item.DataItem("PunchOutTime"), 1, e.Item.DataItem("TimeRecordID"), e.Item.DataItem("AttendenceType"), NotesCounter)

                    If e.Item.DataItem("PunchOutTime") Is DBNull.Value = False Then
                        CType(e.Item.FindControl("ltrlTimeOut"), Literal).Text = FormatEditAttributes(DateTime.Parse(e.Item.DataItem("PunchOutTime")).ToString("hh:mm"), e.Item.DataItem("PunchInTime"), e.Item.DataItem("PunchOutTime"), 2, e.Item.DataItem("TimeRecordID"), e.Item.DataItem("AttendenceType"), -1)
                        CType(e.Item.FindControl("ltrlTimeOutOffSet"), Literal).Text = FormatEditAttributes(DateTime.Parse(e.Item.DataItem("PunchOutTime")).ToString("tt"), e.Item.DataItem("PunchInTime"), e.Item.DataItem("PunchOutTime"), 2, e.Item.DataItem("TimeRecordID"), e.Item.DataItem("AttendenceType"), NotesCounter)
                    End If
                    If arrPunchIns.Count < 5 Then
                        e.Item.FindControl("dvTimeInTimeOut").Visible = True
                    End If

                    If e.Item.DataItem("PunchOutTime") Is DBNull.Value = False Then
                        WorkingMinutesEachDay = WorkingMinutesEachDay + DateDiff(DateInterval.Minute, DateTime.Parse(DateTime.Parse(e.Item.DataItem("PunchInTime")).ToString("MM-dd-yyyy hh:mm tt")), DateTime.Parse(DateTime.Parse(e.Item.DataItem("PunchOutTime")).ToString("MM-dd-yyyy hh:mm tt")))
                    End If

                    TotalLateArrivals = TotalLateArrivals + IIf(e.Item.DataItem("IsLateArrival") Is DBNull.Value, 0, e.Item.DataItem("IsLateArrival"))
                    TotalEarlyDeparture = TotalEarlyDeparture + IIf(e.Item.DataItem("HasEarlyDeparture") Is DBNull.Value, 0, e.Item.DataItem("HasEarlyDeparture"))
                    TotalLateSittings = TotalLateSittings + IIf(e.Item.DataItem("HasLateSitting") Is DBNull.Value, 0, e.Item.DataItem("HasLateSitting"))


                    arrPunchIns.Add(e.Item.DataItem("PunchInTime"))
                    If e.Item.DataItem("PunchOutTime") Is DBNull.Value Then
                        arrPunchOuts.Add("00:00")
                    Else
                        arrPunchOuts.Add(e.Item.DataItem("PunchOutTime"))
                    End If
                    If Not String.IsNullOrEmpty(e.Item.DataItem("LastUpdatedNotes")) Then
                        UpdatedByUser = e.Item.DataItem("LastUpdatedNotes")
                        If Not e.Item.DataItem("UpdatedOn") Is DBNull.Value Then
                            UpdatedByUser = UpdatedByUser & IIf(e.Item.DataItem("UpdatedByUser") Is DBNull.Value, "", "<br />" & "<span style='font-style:italic; font-size:11px;'>" & e.Item.DataItem("UpdatedByUser") & " on " & CDate(e.Item.DataItem("UpdatedOn")).ToString("MM-dd-yyyy hh:mm tt") & "</span>")
                        End If
                        ArrNotes.Add(UpdatedByUser)
                    End If
                    If Not String.IsNullOrEmpty(e.Item.DataItem("LateArrivalNotes")) Then
                        REM ArrNotes.Add(e.Item.DataItem("LateArrivalNotes"))
                        Me.ArrLateArrivalNotes.Add(e.Item.DataItem("LateArrivalNotes"))
                    End If
                    If Not String.IsNullOrEmpty(e.Item.DataItem("EarlyDepartureNotes")) Then
                        REM ArrNotes.Add(e.Item.DataItem("EarlyDepartureNotes"))
                        Me.ArrEarlyDepartureNotes.Add(e.Item.DataItem("EarlyDepartureNotes"))
                    End If
                    If Not String.IsNullOrEmpty(e.Item.DataItem("LateSittingNotes")) Then
                        REM ArrNotes.Add(e.Item.DataItem("LateSittingNotes"))
                        Me.ArrLateSittingNotes.Add(e.Item.DataItem("LateSittingNotes"))
                    End If


                    ResetTimeHistoryFlag(e.Item.DataItem("IsLateArrival"), e.Item.DataItem("HasEarlyDeparture"), e.Item.DataItem("HasLateSitting"))
                    PrintingTimeInTimeOut = PrintingTimeInTimeOut + 1
                End If

                AnnualLeavesAllowed = e.Item.DataItem("AnnualLeavesAllowed")
                AnnualLeavesTaken = e.Item.DataItem("AnnualLeavesTaken")
                AnnualLeavesBalance = e.Item.DataItem("AnnualLeavesBalance")
                CausalLeavesAllowed = e.Item.DataItem("CausalLeavesAllowed")
                CausalLeavesTaken = e.Item.DataItem("CausalLeavesTaken")
                CausalLeavesBalance = e.Item.DataItem("CausalLeavesBalance")

                If e.Item.DataItem("WeekDayID") = Portal.BLL.Enumeration.DayOfWeekSQLServer.Saturday Then
                    MinimumOfficeWorkingMinutes = e.Item.DataItem("TotalWorkingMinutesOnSaturday")
                Else
                    MinimumOfficeWorkingMinutes = e.Item.DataItem("TotalWorkingMinutes")
                End If

            ElseIf UserID > 0 And UserID <> e.Item.DataItem("UserID") Then
                e.Item.FindControl("ltrldivContainerStart").Visible = True
                e.Item.FindControl("ltrldivContainerEnd").Visible = True
                REM PrintingTimeInTimeOut = 0
                If PrintingTimeInTimeOut > 0 Then
                    CType(e.Item.FindControl("ltrlEmptyDivs"), Literal).Text = GetEmptyDivs(PrintingTimeInTimeOut)
                    PrintingTimeInTimeOut = 0
                End If
                e.Item.FindControl("dvInnerTotal").Visible = True

                CType(e.Item.FindControl("ltrlTotalHours"), Literal).Text = GetTotalHours(WorkingMinutesEachDay, MinimumOfficeWorkingMinutes)
                If arrPunchIns.Count > 0 Then
                    If TotalLateArrivals > 0 Then
                        CType(e.Item.FindControl("ltrlLA"), Literal).Text = TotalLateArrivals
                        CType(e.Item.FindControl("dvLA"), HtmlControl).Style.Add("cursor", "pointer")
                        CType(e.Item.FindControl("dvLA"), HtmlControl).Attributes.Add("onmouseover", "ShowNotes('" & FormatNotes(Me.ArrLateArrivalNotes) & "',this);")
                        CType(e.Item.FindControl("dvLA"), HtmlControl).Attributes.Add("onmouseout", "HideNotes();")
                    End If
                    If TotalEarlyDeparture > 0 Then
                        CType(e.Item.FindControl("ltrlED"), Literal).Text = TotalEarlyDeparture
                        CType(e.Item.FindControl("dvED"), HtmlControl).Style.Add("cursor", "pointer")
                        CType(e.Item.FindControl("dvED"), HtmlControl).Attributes.Add("onmouseover", "ShowNotes('" & FormatNotes(Me.ArrEarlyDepartureNotes) & "',this);")
                        CType(e.Item.FindControl("dvED"), HtmlControl).Attributes.Add("onmouseout", "HideNotes();")
                    End If
                    If TotalLateSittings > 0 Then
                        CType(e.Item.FindControl("ltrlLS"), Literal).Text = TotalLateSittings
                        CType(e.Item.FindControl("dvLS"), HtmlControl).Style.Add("cursor", "pointer")
                        CType(e.Item.FindControl("dvLS"), HtmlControl).Attributes.Add("onmouseover", "ShowNotes('" & FormatNotes(Me.ArrLateSittingNotes) & "',this);")
                        CType(e.Item.FindControl("dvLS"), HtmlControl).Attributes.Add("onmouseout", "HideNotes();")
                    End If

                    CType(e.Item.FindControl("imgLA"), Image).Visible = CheckUserTimeHistoryFlags(1)
                    CType(e.Item.FindControl("imgED"), Image).Visible = CheckUserTimeHistoryFlags(2)
                    CType(e.Item.FindControl("imgLS"), Image).Visible = CheckUserTimeHistoryFlags(3)

                    If ArrNotes.Count > 0 Then
                        CType(e.Item.FindControl("imgNotes"), Image).Attributes.Add("onmouseover", "ShowNotes('" & FormatNotes(Me.ArrNotes) & "',this);")
                        CType(e.Item.FindControl("imgNotes"), Image).Attributes.Add("onmouseout", "HideNotes();")
                        CType(e.Item.FindControl("imgNotes"), Image).Visible = True
                    Else
                        CType(e.Item.FindControl("imgNotes"), Image).Visible = False
                    End If
                End If
                TotalWorkingMinutes = TotalWorkingMinutes + WorkingMinutesEachDay
                e.Item.FindControl("dvRowTotal").Visible = True
                CType(e.Item.FindControl("ltrlUserTotalHours"), Literal).Text = GetTotalHours(TotalWorkingMinutes, MinimumOfficeWorkingMinutes)

                e.Item.FindControl("dvTotals").Visible = True

                CType(e.Item.FindControl("ltrlAL_A"), Literal).Text = AnnualLeavesAllowed
                CType(e.Item.FindControl("ltrlAL_T"), Literal).Text = AnnualLeavesTaken
                CType(e.Item.FindControl("ltrlAL_B"), Literal).Text = AnnualLeavesBalance
                'CType(e.Item.FindControl("ltrlCL_A"), Literal).Text = CausalLeavesAllowed
                'CType(e.Item.FindControl("ltrlCL_T"), Literal).Text = CausalLeavesTaken
                'CType(e.Item.FindControl("ltrlCL_B"), Literal).Text = CausalLeavesBalance


                e.Item.FindControl("dvTotalsInOutCells").Visible = True
                e.Item.FindControl("ltrlEmptyDivsTotal").Visible = True
                CType(e.Item.FindControl("ltrlEmptyDivsTotal"), Literal).Text = GetEmptyDivsForTotalRow(0)

                e.Item.FindControl("dvBreaker").Visible = True
                e.Item.FindControl("dvName").Visible = True
                CType(e.Item.FindControl("dvName"), System.Web.UI.HtmlControls.HtmlControl).Style.Add("clear", "both")
                e.Item.FindControl("dvDate").Visible = True
                e.Item.FindControl("dvInOutNote").Visible = True
                TotalWorkingMinutes = 0
                WorkingMinutesEachDay = 0
                TotalLateArrivals = 0
                TotalEarlyDeparture = 0
                TotalLateSittings = 0
                arrPunchIns.Clear()
                arrPunchOuts.Clear()
                ArrNotes.Clear()
                NotesCounter = 0
                ArrLateArrivalNotes.Clear()
                ArrEarlyDepartureNotes.Clear()
                ArrLateSittingNotes.Clear()
                ResetTimeHistoryFlag(False, False, False)
                AnnualLeavesAllowed = e.Item.DataItem("AnnualLeavesAllowed")
                AnnualLeavesTaken = e.Item.DataItem("AnnualLeavesTaken")
                AnnualLeavesBalance = e.Item.DataItem("AnnualLeavesBalance")
                CausalLeavesAllowed = e.Item.DataItem("CausalLeavesAllowed")
                CausalLeavesTaken = e.Item.DataItem("CausalLeavesTaken")
                CausalLeavesBalance = e.Item.DataItem("CausalLeavesBalance")


                If e.Item.DataItem("WeekDayID") = Portal.BLL.Enumeration.DayOfWeekSQLServer.Saturday Then
                    MinimumOfficeWorkingMinutes = e.Item.DataItem("TotalWorkingMinutesOnSaturday")
                Else
                    MinimumOfficeWorkingMinutes = e.Item.DataItem("TotalWorkingMinutes")
                End If


                If e.Item.DataItem("PunchInTime") Is DBNull.Value Then
                    REM CType(e.Item.FindControl("ltrlOffDays"), Literal).Text = GetOffDaysHtml(arrUserTempDates, DateTime.Parse(e.Item.DataItem("PunchInDate")), e.Item.DataItem("OffSaturdayDate")).ToString()
                    CType(e.Item.FindControl("ltrlOffDays"), Literal).Text = GetOffDaysHtml(DateTime.Parse(e.Item.DataItem("PunchInDate")), e.Item.DataItem("OffDayType")).ToString()
                    CType(e.Item.FindControl("ltrlOffDays"), Literal).Visible = True
                Else
                    CType(e.Item.FindControl("ltrlTimeIn"), Literal).Text = FormatEditAttributes(DateTime.Parse(e.Item.DataItem("PunchInTime")).ToString("hh:mm"), e.Item.DataItem("PunchInTime"), e.Item.DataItem("PunchOutTime"), 1, e.Item.DataItem("TimeRecordID"), e.Item.DataItem("AttendenceType"), -1)
                    CType(e.Item.FindControl("ltrlTimeOffSet"), Literal).Text = FormatEditAttributes(DateTime.Parse(e.Item.DataItem("PunchInTime")).ToString("tt"), e.Item.DataItem("PunchInTime"), e.Item.DataItem("PunchOutTime"), 1, e.Item.DataItem("TimeRecordID"), e.Item.DataItem("AttendenceType"), NotesCounter)
                    If e.Item.DataItem("PunchOutTime") Is DBNull.Value = False Then
                        CType(e.Item.FindControl("ltrlTimeOut"), Literal).Text = FormatEditAttributes(DateTime.Parse(e.Item.DataItem("PunchOutTime")).ToString("hh:mm"), e.Item.DataItem("PunchInTime"), e.Item.DataItem("PunchOutTime"), 2, e.Item.DataItem("TimeRecordID"), e.Item.DataItem("AttendenceType"), -1)
                        CType(e.Item.FindControl("ltrlTimeOutOffSet"), Literal).Text = FormatEditAttributes(DateTime.Parse(e.Item.DataItem("PunchOutTime")).ToString("tt"), e.Item.DataItem("PunchInTime"), e.Item.DataItem("PunchOutTime"), 2, e.Item.DataItem("TimeRecordID"), e.Item.DataItem("AttendenceType"), NotesCounter)
                    End If
                    If arrPunchIns.Count < 5 Then
                        e.Item.FindControl("dvTimeInTimeOut").Visible = True
                    End If

                    PrintingTimeInTimeOut = PrintingTimeInTimeOut + 1
                    If e.Item.DataItem("PunchOutTime") Is DBNull.Value = False Then
                        WorkingMinutesEachDay = WorkingMinutesEachDay + DateDiff(DateInterval.Minute, DateTime.Parse(DateTime.Parse(e.Item.DataItem("PunchInTime")).ToString("MM-dd-yyyy hh:mm tt")), DateTime.Parse(DateTime.Parse(e.Item.DataItem("PunchOutTime")).ToString("MM-dd-yyyy hh:mm tt")))
                    End If
                    TotalLateArrivals = TotalLateArrivals + IIf(e.Item.DataItem("IsLateArrival") Is DBNull.Value, 0, e.Item.DataItem("IsLateArrival"))
                    TotalEarlyDeparture = TotalEarlyDeparture + IIf(e.Item.DataItem("HasEarlyDeparture") Is DBNull.Value, 0, e.Item.DataItem("HasEarlyDeparture"))
                    TotalLateSittings = TotalLateSittings + IIf(e.Item.DataItem("HasLateSitting") Is DBNull.Value, 0, e.Item.DataItem("HasLateSitting"))

                    arrPunchIns.Add(e.Item.DataItem("PunchInTime"))
                    If e.Item.DataItem("PunchOutTime") Is DBNull.Value Then
                        arrPunchOuts.Add("00:00")
                    Else
                        arrPunchOuts.Add(e.Item.DataItem("PunchOutTime"))
                    End If
                    If Not String.IsNullOrEmpty(e.Item.DataItem("LastUpdatedNotes")) Then
                        UpdatedByUser = e.Item.DataItem("LastUpdatedNotes")
                        If Not e.Item.DataItem("UpdatedOn") Is DBNull.Value Then
                            UpdatedByUser = UpdatedByUser & IIf(e.Item.DataItem("UpdatedByUser") Is DBNull.Value, "", "<br />" & "<span style='font-style:italic; font-size:11px;'>" & e.Item.DataItem("UpdatedByUser") & " on " & CDate(e.Item.DataItem("UpdatedOn")).ToString("MM-dd-yyyy hh:mm tt") & "</span>")
                        End If
                        ArrNotes.Add(UpdatedByUser)
                    End If
                    If Not String.IsNullOrEmpty(e.Item.DataItem("LateArrivalNotes")) Then
                        REM ArrNotes.Add(e.Item.DataItem("LateArrivalNotes"))
                        Me.ArrLateArrivalNotes.Add(e.Item.DataItem("LateArrivalNotes"))
                    End If
                    If Not String.IsNullOrEmpty(e.Item.DataItem("EarlyDepartureNotes")) Then
                        REM ArrNotes.Add(e.Item.DataItem("EarlyDepartureNotes"))
                        Me.ArrEarlyDepartureNotes.Add(e.Item.DataItem("EarlyDepartureNotes"))
                    End If
                    If Not String.IsNullOrEmpty(e.Item.DataItem("LateSittingNotes")) Then
                        REM ArrNotes.Add(e.Item.DataItem("LateSittingNotes"))
                        Me.ArrLateSittingNotes.Add(e.Item.DataItem("LateSittingNotes"))
                    End If
                    Me.ResetTimeHistoryFlag(e.Item.DataItem("IsLateArrival"), e.Item.DataItem("HasEarlyDeparture"), e.Item.DataItem("HasLateSitting"))
                End If
            Else REM  Same User 

                If CurrentDate.ToShortDateString() = DateTime.Parse(e.Item.DataItem("PunchInDate")).ToShortDateString() Then
                    e.Item.FindControl("dvName").Visible = False
                    e.Item.FindControl("dvDate").Visible = False
                    e.Item.FindControl("dvInOutNote").Visible = False
                    If arrPunchIns.Count < 5 Then
                        e.Item.FindControl("dvTimeInTimeOut").Visible = True
                    End If

                    CType(e.Item.FindControl("dvTimeInTimeOut"), System.Web.UI.HtmlControls.HtmlControl).Style.Add("float", "left")
                    CType(e.Item.FindControl("dvTimeInTimeOut"), System.Web.UI.HtmlControls.HtmlControl).Style.Add("border", "solid 0px red")
                    e.Item.FindControl("dvInnerTotal").Visible = False

                    CType(e.Item.FindControl("ltrlTimeIn"), Literal).Text = FormatEditAttributes(DateTime.Parse(e.Item.DataItem("PunchInTime")).ToString("hh:mm"), e.Item.DataItem("PunchInTime"), e.Item.DataItem("PunchOutTime"), 1, e.Item.DataItem("TimeRecordID"), e.Item.DataItem("AttendenceType"), -1)
                    CType(e.Item.FindControl("ltrlTimeOffSet"), Literal).Text = FormatEditAttributes(DateTime.Parse(e.Item.DataItem("PunchInTime")).ToString("tt"), e.Item.DataItem("PunchInTime"), e.Item.DataItem("PunchOutTime"), 1, e.Item.DataItem("TimeRecordID"), e.Item.DataItem("AttendenceType"), NotesCounter)

                    If e.Item.DataItem("PunchOutTime") Is DBNull.Value = False Then
                        CType(e.Item.FindControl("ltrlTimeOut"), Literal).Text = FormatEditAttributes(DateTime.Parse(e.Item.DataItem("PunchOutTime")).ToString("hh:mm"), e.Item.DataItem("PunchInTime"), e.Item.DataItem("PunchOutTime"), 2, e.Item.DataItem("TimeRecordID"), e.Item.DataItem("AttendenceType"), -1)
                        CType(e.Item.FindControl("ltrlTimeOutOffSet"), Literal).Text = FormatEditAttributes(DateTime.Parse(e.Item.DataItem("PunchOutTime")).ToString("tt"), e.Item.DataItem("PunchInTime"), e.Item.DataItem("PunchOutTime"), 2, e.Item.DataItem("TimeRecordID"), e.Item.DataItem("AttendenceType"), NotesCounter)
                    End If
                    PrintingTimeInTimeOut = PrintingTimeInTimeOut + 1
                    If e.Item.DataItem("PunchOutTime") Is DBNull.Value = False Then
                        WorkingMinutesEachDay = WorkingMinutesEachDay + DateDiff(DateInterval.Minute, DateTime.Parse(DateTime.Parse(e.Item.DataItem("PunchInTime")).ToString("MM-dd-yyyy hh:mm tt")), DateTime.Parse(DateTime.Parse(e.Item.DataItem("PunchOutTime")).ToString("MM-dd-yyyy hh:mm tt")))
                    End If
                    TotalLateArrivals = TotalLateArrivals + IIf(e.Item.DataItem("IsLateArrival") Is DBNull.Value, 0, e.Item.DataItem("IsLateArrival"))
                    TotalEarlyDeparture = TotalEarlyDeparture + IIf(e.Item.DataItem("HasEarlyDeparture") Is DBNull.Value, 0, e.Item.DataItem("HasEarlyDeparture"))
                    TotalLateSittings = TotalLateSittings + IIf(e.Item.DataItem("HasLateSitting") Is DBNull.Value, 0, e.Item.DataItem("HasLateSitting"))

                    arrPunchIns.Add(e.Item.DataItem("PunchInTime"))
                    If e.Item.DataItem("PunchOutTime") Is DBNull.Value Then
                        arrPunchOuts.Add("00:00")
                    Else
                        arrPunchOuts.Add(e.Item.DataItem("PunchOutTime"))
                    End If
                    If Not String.IsNullOrEmpty(e.Item.DataItem("LastUpdatedNotes")) Then
                        UpdatedByUser = e.Item.DataItem("LastUpdatedNotes")
                        If Not e.Item.DataItem("UpdatedOn") Is DBNull.Value Then
                            UpdatedByUser = UpdatedByUser & IIf(e.Item.DataItem("UpdatedByUser") Is DBNull.Value, "", "<br />" & "<span style='font-style:italic; font-size:11px;'>" & e.Item.DataItem("UpdatedByUser") & " on " & CDate(e.Item.DataItem("UpdatedOn")).ToString("MM-dd-yyyy hh:mm tt") & "</span>")
                        End If
                        ArrNotes.Add(UpdatedByUser)
                    End If
                    If Not String.IsNullOrEmpty(e.Item.DataItem("LateArrivalNotes")) Then
                        REM ArrNotes.Add(e.Item.DataItem("LateArrivalNotes"))
                        Me.ArrLateArrivalNotes.Add(e.Item.DataItem("LateArrivalNotes"))
                    End If
                    If Not String.IsNullOrEmpty(e.Item.DataItem("EarlyDepartureNotes")) Then
                        REM ArrNotes.Add(e.Item.DataItem("EarlyDepartureNotes"))
                        Me.ArrEarlyDepartureNotes.Add(e.Item.DataItem("EarlyDepartureNotes"))
                    End If
                    If Not String.IsNullOrEmpty(e.Item.DataItem("LateSittingNotes")) Then
                        REM ArrNotes.Add(e.Item.DataItem("LateSittingNotes"))
                        Me.ArrLateSittingNotes.Add(e.Item.DataItem("LateSittingNotes"))
                    End If
                    Me.ResetTimeHistoryFlag(e.Item.DataItem("IsLateArrival"), e.Item.DataItem("HasEarlyDeparture"), e.Item.DataItem("HasLateSitting"))

                    AnnualLeavesAllowed = e.Item.DataItem("AnnualLeavesAllowed")
                    AnnualLeavesTaken = e.Item.DataItem("AnnualLeavesTaken")
                    AnnualLeavesBalance = e.Item.DataItem("AnnualLeavesBalance")
                    CausalLeavesAllowed = e.Item.DataItem("CausalLeavesAllowed")
                    CausalLeavesTaken = e.Item.DataItem("CausalLeavesTaken")
                    CausalLeavesBalance = e.Item.DataItem("CausalLeavesBalance")


                    If e.Item.DataItem("WeekDayID") = Portal.BLL.Enumeration.DayOfWeekSQLServer.Saturday Then
                        MinimumOfficeWorkingMinutes = e.Item.DataItem("TotalWorkingMinutesOnSaturday")
                    Else
                        MinimumOfficeWorkingMinutes = e.Item.DataItem("TotalWorkingMinutes")
                    End If


                Else  REM Different Date

                    e.Item.FindControl("ltrldivContainerStart").Visible = True
                    e.Item.FindControl("ltrldivContainerEnd").Visible = True
                    If PrintingTimeInTimeOut > 0 Then
                        CType(e.Item.FindControl("ltrlEmptyDivs"), Literal).Text = GetEmptyDivs(PrintingTimeInTimeOut)
                        PrintingTimeInTimeOut = 0
                    End If
                    e.Item.FindControl("dvInnerTotal").Visible = True
                    CType(e.Item.FindControl("ltrlTotalHours"), Literal).Text = GetTotalHours(WorkingMinutesEachDay, MinimumOfficeWorkingMinutes)
                    TotalWorkingMinutes = TotalWorkingMinutes + WorkingMinutesEachDay
                    If arrPunchIns.Count > 0 Then
                        If TotalLateArrivals > 0 Then
                            CType(e.Item.FindControl("ltrlLA"), Literal).Text = TotalLateArrivals
                            CType(e.Item.FindControl("dvLA"), HtmlControl).Style.Add("cursor", "pointer")
                            CType(e.Item.FindControl("dvLA"), HtmlControl).Attributes.Add("onmouseover", "ShowNotes('" & FormatNotes(Me.ArrLateArrivalNotes) & "',this);")
                            CType(e.Item.FindControl("dvLA"), HtmlControl).Attributes.Add("onmouseout", "HideNotes();")
                        End If
                        If TotalEarlyDeparture > 0 Then
                            CType(e.Item.FindControl("ltrlED"), Literal).Text = TotalEarlyDeparture
                            CType(e.Item.FindControl("dvED"), HtmlControl).Style.Add("cursor", "pointer")
                            CType(e.Item.FindControl("dvED"), HtmlControl).Attributes.Add("onmouseover", "ShowNotes('" & FormatNotes(Me.ArrEarlyDepartureNotes) & "',this);")
                            CType(e.Item.FindControl("dvED"), HtmlControl).Attributes.Add("onmouseout", "HideNotes();")
                        End If
                        If TotalLateSittings > 0 Then
                            CType(e.Item.FindControl("ltrlLS"), Literal).Text = TotalLateSittings
                            CType(e.Item.FindControl("dvLS"), HtmlControl).Style.Add("cursor", "pointer")
                            CType(e.Item.FindControl("dvLS"), HtmlControl).Attributes.Add("onmouseover", "ShowNotes('" & FormatNotes(Me.ArrLateSittingNotes) & "',this);")
                            CType(e.Item.FindControl("dvLS"), HtmlControl).Attributes.Add("onmouseout", "HideNotes();")
                        End If

                        CType(e.Item.FindControl("imgLA"), Image).Visible = CheckUserTimeHistoryFlags(1)
                        CType(e.Item.FindControl("imgED"), Image).Visible = CheckUserTimeHistoryFlags(2)
                        CType(e.Item.FindControl("imgLS"), Image).Visible = CheckUserTimeHistoryFlags(3)


                        If ArrNotes.Count > 0 Then
                            CType(e.Item.FindControl("imgNotes"), Image).Attributes.Add("onmouseover", "ShowNotes('" & FormatNotes(Me.ArrNotes) & "',this);")
                            CType(e.Item.FindControl("imgNotes"), Image).Attributes.Add("onmouseout", "HideNotes();")
                            CType(e.Item.FindControl("imgNotes"), Image).Visible = True
                        Else
                            CType(e.Item.FindControl("imgNotes"), Image).Visible = False
                        End If
                    End If
                    e.Item.FindControl("dvBreaker2").Visible = True
                    e.Item.FindControl("dvDate").Visible = True
                    e.Item.FindControl("dvInOutNote").Visible = True
                    WorkingMinutesEachDay = 0
                    TotalLateArrivals = 0
                    TotalEarlyDeparture = 0
                    TotalLateSittings = 0
                    arrPunchIns.Clear()
                    arrPunchOuts.Clear()
                    ArrNotes.Clear()
                    ArrLateArrivalNotes.Clear()
                    ArrEarlyDepartureNotes.Clear()
                    ArrLateSittingNotes.Clear()
                    Me.ResetTimeHistoryFlag(False, False, False)
                    If e.Item.DataItem("PunchInTime") Is DBNull.Value Then
                        REM CType(e.Item.FindControl("ltrlOffDays"), Literal).Text = GetOffDaysHtml(arrUserTempDates, DateTime.Parse(e.Item.DataItem("PunchInDate")), e.Item.DataItem("OffSaturdayDate")).ToString()
                        CType(e.Item.FindControl("ltrlOffDays"), Literal).Text = GetOffDaysHtml(DateTime.Parse(e.Item.DataItem("PunchInDate")), e.Item.DataItem("OffDayType")).ToString()
                        CType(e.Item.FindControl("ltrlOffDays"), Literal).Visible = True
                    Else
                        CType(e.Item.FindControl("ltrlTimeIn"), Literal).Text = FormatEditAttributes(DateTime.Parse(e.Item.DataItem("PunchInTime")).ToString("hh:mm"), e.Item.DataItem("PunchInTime"), e.Item.DataItem("PunchOutTime"), 1, e.Item.DataItem("TimeRecordID"), e.Item.DataItem("AttendenceType"), -1)
                        CType(e.Item.FindControl("ltrlTimeOffSet"), Literal).Text = FormatEditAttributes(DateTime.Parse(e.Item.DataItem("PunchInTime")).ToString("tt"), e.Item.DataItem("PunchInTime"), e.Item.DataItem("PunchOutTime"), 1, e.Item.DataItem("TimeRecordID"), e.Item.DataItem("AttendenceType"), NotesCounter)
                        If e.Item.DataItem("PunchOutTime") Is DBNull.Value = False Then
                            CType(e.Item.FindControl("ltrlTimeOut"), Literal).Text = FormatEditAttributes(DateTime.Parse(e.Item.DataItem("PunchOutTime")).ToString("hh:mm"), e.Item.DataItem("PunchInTime"), e.Item.DataItem("PunchOutTime"), 2, e.Item.DataItem("TimeRecordID"), e.Item.DataItem("AttendenceType"), -1)
                            CType(e.Item.FindControl("ltrlTimeOutOffSet"), Literal).Text = FormatEditAttributes(DateTime.Parse(e.Item.DataItem("PunchOutTime")).ToString("tt"), e.Item.DataItem("PunchInTime"), e.Item.DataItem("PunchOutTime"), 2, e.Item.DataItem("TimeRecordID"), e.Item.DataItem("AttendenceType"), NotesCounter)
                        End If
                        If arrPunchIns.Count < 5 Then
                            e.Item.FindControl("dvTimeInTimeOut").Visible = True
                        End If

                        PrintingTimeInTimeOut = PrintingTimeInTimeOut + 1
                        If e.Item.DataItem("PunchoutTime") Is DBNull.Value = False Then
                            WorkingMinutesEachDay = WorkingMinutesEachDay + DateDiff(DateInterval.Minute, DateTime.Parse(DateTime.Parse(e.Item.DataItem("PunchInTime")).ToString("MM-dd-yyyy hh:mm tt")), DateTime.Parse(DateTime.Parse(e.Item.DataItem("PunchOutTime")).ToString("MM-dd-yyyy hh:mm tt")))
                        End If
                        TotalLateArrivals = TotalLateArrivals + IIf(e.Item.DataItem("IsLateArrival") Is DBNull.Value, 0, e.Item.DataItem("IsLateArrival"))
                        TotalEarlyDeparture = TotalEarlyDeparture + IIf(e.Item.DataItem("HasEarlyDeparture") Is DBNull.Value, 0, e.Item.DataItem("HasEarlyDeparture"))
                        TotalLateSittings = TotalLateSittings + IIf(e.Item.DataItem("HasLateSitting") Is DBNull.Value, 0, e.Item.DataItem("HasLateSitting"))

                        arrPunchIns.Add(e.Item.DataItem("PunchInTime"))
                        If e.Item.DataItem("PunchOutTime") Is DBNull.Value Then
                            arrPunchOuts.Add("00:00")
                        Else
                            arrPunchOuts.Add(e.Item.DataItem("PunchOutTime"))
                        End If
                        If Not String.IsNullOrEmpty(e.Item.DataItem("LastUpdatedNotes")) Then
                            UpdatedByUser = e.Item.DataItem("LastUpdatedNotes")
                            If Not e.Item.DataItem("UpdatedOn") Is DBNull.Value Then
                                UpdatedByUser = UpdatedByUser & IIf(e.Item.DataItem("UpdatedByUser") Is DBNull.Value, "", "<br />" & "<span style='font-style:italic; font-size:11px;'>" & e.Item.DataItem("UpdatedByUser") & " on " & CDate(e.Item.DataItem("UpdatedOn")).ToString("MM-dd-yyyy hh:mm tt") & "</span>")
                            End If
                            ArrNotes.Add(UpdatedByUser)
                        End If
                        If Not String.IsNullOrEmpty(e.Item.DataItem("LateArrivalNotes")) Then
                            REM ArrNotes.Add(e.Item.DataItem("LateArrivalNotes"))
                            Me.ArrLateArrivalNotes.Add(e.Item.DataItem("LateArrivalNotes"))
                        End If
                        If Not String.IsNullOrEmpty(e.Item.DataItem("EarlyDepartureNotes")) Then
                            REM ArrNotes.Add(e.Item.DataItem("EarlyDepartureNotes"))
                            Me.ArrEarlyDepartureNotes.Add(e.Item.DataItem("EarlyDepartureNotes"))
                        End If
                        If Not String.IsNullOrEmpty(e.Item.DataItem("LateSittingNotes")) Then
                            REM ArrNotes.Add(e.Item.DataItem("LateSittingNotes"))
                            Me.ArrLateSittingNotes.Add(e.Item.DataItem("LateSittingNotes"))
                        End If
                        Me.ResetTimeHistoryFlag(e.Item.DataItem("IsLateArrival"), e.Item.DataItem("HasEarlyDeparture"), e.Item.DataItem("HasLateSitting"))
                        AnnualLeavesAllowed = e.Item.DataItem("AnnualLeavesAllowed")
                        AnnualLeavesTaken = e.Item.DataItem("AnnualLeavesTaken")
                        AnnualLeavesBalance = e.Item.DataItem("AnnualLeavesBalance")
                        CausalLeavesAllowed = e.Item.DataItem("CausalLeavesAllowed")
                        CausalLeavesTaken = e.Item.DataItem("CausalLeavesTaken")
                        CausalLeavesBalance = e.Item.DataItem("CausalLeavesBalance")



                        If e.Item.DataItem("WeekDayID") = Portal.BLL.Enumeration.DayOfWeekSQLServer.Saturday Then
                            MinimumOfficeWorkingMinutes = e.Item.DataItem("TotalWorkingMinutesOnSaturday")
                        Else
                            MinimumOfficeWorkingMinutes = e.Item.DataItem("TotalWorkingMinutes")
                        End If

                    End If

                End If

            End If
            UserID = e.Item.DataItem("UserID")
            CurrentDate = e.Item.DataItem("PunchInDate")
            CurrentRow = CurrentRow + 1
        End If
        If e.Item.ItemType = ListItemType.Footer Then
            If CurrentRow = TotalRows Then
                If CurrentRow = 0 Then
                    e.Item.FindControl("divNoRecord").Visible = True
                Else
                    e.Item.FindControl("ltrldivContainerEnd").Visible = True
                    If PrintingTimeInTimeOut > 0 Then
                        CType(e.Item.FindControl("ltrlEmptyDivs"), Literal).Text = GetEmptyDivs(PrintingTimeInTimeOut)
                    End If
                    e.Item.FindControl("dvInnerTotal").Visible = True
                    e.Item.FindControl("dvRowTotal").Visible = True
                    CType(e.Item.FindControl("ltrlTotalHours"), Literal).Text = GetTotalHours(WorkingMinutesEachDay, MinimumOfficeWorkingMinutes)
                    If arrPunchIns.Count > 0 Then
                        Try
                            If TotalLateArrivals > 0 Then
                                CType(e.Item.FindControl("ltrlLA"), Literal).Text = TotalLateArrivals
                                CType(e.Item.FindControl("dvLA"), HtmlControl).Style.Add("cursor", "pointer")
                                CType(e.Item.FindControl("dvLA"), HtmlControl).Attributes.Add("onmouseover", "ShowNotes('" & FormatNotes(Me.ArrLateArrivalNotes) & "',this);")
                                CType(e.Item.FindControl("dvLA"), HtmlControl).Attributes.Add("onmouseout", "HideNotes();")
                            End If
                            If TotalEarlyDeparture > 0 Then
                                CType(e.Item.FindControl("ltrlED"), Literal).Text = TotalEarlyDeparture
                                CType(e.Item.FindControl("dvED"), HtmlControl).Style.Add("cursor", "pointer")
                                CType(e.Item.FindControl("dvED"), HtmlControl).Attributes.Add("onmouseover", "ShowNotes('" & FormatNotes(Me.ArrEarlyDepartureNotes) & "',this);")
                                CType(e.Item.FindControl("dvED"), HtmlControl).Attributes.Add("onmouseout", "HideNotes();")
                            End If
                            If TotalLateSittings > 0 Then
                                CType(e.Item.FindControl("ltrlLS"), Literal).Text = TotalLateSittings
                                CType(e.Item.FindControl("dvLS"), HtmlControl).Style.Add("cursor", "pointer")
                                CType(e.Item.FindControl("dvLS"), HtmlControl).Attributes.Add("onmouseover", "ShowNotes('" & FormatNotes(Me.ArrLateSittingNotes) & "',this);")
                                CType(e.Item.FindControl("dvLS"), HtmlControl).Attributes.Add("onmouseout", "HideNotes();")
                            End If
                            CType(e.Item.FindControl("imgLA"), Image).Visible = CheckUserTimeHistoryFlags(1)
                            CType(e.Item.FindControl("imgED"), Image).Visible = CheckUserTimeHistoryFlags(2)
                            CType(e.Item.FindControl("imgLS"), Image).Visible = CheckUserTimeHistoryFlags(3)



                            If Me.ArrNotes.Count > 0 Then
                                CType(e.Item.FindControl("imgNotes"), Image).Attributes.Add("onmouseover", "ShowNotes('" & FormatNotes(Me.ArrNotes) & "',this);")
                                CType(e.Item.FindControl("imgNotes"), Image).Attributes.Add("onmouseout", "HideNotes();")
                                CType(e.Item.FindControl("imgNotes"), Image).Visible = True
                            Else
                                CType(e.Item.FindControl("imgNotes"), Image).Visible = False
                            End If
                        Catch ex As Exception

                        End Try
                    End If
                    e.Item.FindControl("dvTotals").Visible = True
                    CType(e.Item.FindControl("ltrlAL_A"), Literal).Text = AnnualLeavesAllowed
                    CType(e.Item.FindControl("ltrlAL_T"), Literal).Text = AnnualLeavesTaken
                    CType(e.Item.FindControl("ltrlAL_B"), Literal).Text = AnnualLeavesBalance
                    'CType(e.Item.FindControl("ltrlCL_A"), Literal).Text = CausalLeavesAllowed
                    'CType(e.Item.FindControl("ltrlCL_T"), Literal).Text = CausalLeavesTaken
                    'CType(e.Item.FindControl("ltrlCL_B"), Literal).Text = CausalLeavesBalance

                    e.Item.FindControl("dvTotalsInOutCells").Visible = True
                    e.Item.FindControl("ltrlEmptyDivsTotal").Visible = True
                    CType(e.Item.FindControl("ltrlEmptyDivsTotal"), Literal).Text = GetEmptyDivsForTotalRow(0)
                    e.Item.FindControl("dvBreaker2").Visible = True
                    TotalWorkingMinutes = TotalWorkingMinutes + WorkingMinutesEachDay
                    CType(e.Item.FindControl("ltrlUserTotalHours"), Literal).Text = GetTotalHours(TotalWorkingMinutes, MinimumOfficeWorkingMinutes)
                End If
            End If
        End If
    End Sub

    Private Function FormatEditAttributes(ByVal Input As String, _
                                          ByVal TimeIn As DateTime, _
                                          ByVal TimeOut As Object, _
                                          ByVal Type As Integer, _
                                          ByVal TimeRecordID As Integer, _
                                          ByVal AttendenceType As Integer, _
                                          ByVal NoteNumber As Integer) As String
        Try
            Dim ClassName As String = String.Empty
            If AttendenceType = Portal.BLL.Enumeration.AttendenceTypes.TimeCorrection Then
                ClassName = " TimeCellTimeCorrection"
            ElseIf AttendenceType = Portal.BLL.Enumeration.AttendenceTypes.ShortLeave Then
                ClassName = " TimeCellTimeShortLeave"
            ElseIf AttendenceType = Portal.BLL.Enumeration.AttendenceTypes.OutDuty Then
                ClassName = " TimeCellTimeOutDuty"
            End If

            Dim StrReturn As String = ""
            If Me.hdnHasEditAccess.Value = "1" Then
                StrReturn = StrReturn & "<span class='EditTimeRecord" & ClassName & "' onload='" & "" & "' onclick=""EditTime('" & TimeRecordID & "');"">"
            Else
                StrReturn = StrReturn & "<span class='" & ClassName & "' >"
            End If
            StrReturn = StrReturn & Input
            StrReturn = StrReturn & "</span>"
            If NoteNumber <> -1 Then
                REM StrReturn = StrReturn & "<sup style='font-weight:normal; font-size:10px; padding-left:3px;'>" & NoteNumber & "</sup>"
            End If
            Return StrReturn
        Catch ex As Exception

        End Try


    End Function

    Private Function CheckUserTimeHistoryFlags(ByVal FlagType As Integer) As Boolean
        Dim blnReturn As Boolean = False
        If FlagType = 1 Then
            blnReturn = Me.IsLateArrival
        ElseIf FlagType = 2 Then
            blnReturn = Me.HasEarlyDeparture
        ElseIf FlagType = 3 Then
            blnReturn = Me.HasLateSitting
        Else
            blnReturn = False
        End If
        Return blnReturn
    End Function


    Private Function FormatNotes(ByVal Notes As System.Collections.ArrayList) As String
        Dim StrHtml As String = String.Empty
        Dim counter As Integer = 0
        While counter < Notes.Count
            If Not String.IsNullOrEmpty(Notes(counter)) Then
                StrHtml = StrHtml & Notes(counter).ToString().Replace("'", "`").Replace(vbCrLf, " ")
                StrHtml = StrHtml & "###NewNote###"
            End If
            counter = counter + 1
        End While
        Return StrHtml.Trim("'")
    End Function

    Private Function GetTotalHours(ByVal Minutes As Integer) As String
        Dim StrReturn As String = String.Empty
        'Dim TotalHours As Integer = 0
        'Dim TotalMinutes As Integer = 0
        'Dim MaximumWorkingMinutes As Integer = MinimumOfficeTimmingMinute + 120
        'TotalMinutes = Minutes Mod 60
        'TotalHours = (Minutes - TotalMinutes) / 60
        'If Minutes < MinimumOfficeTimmingMinute Then
        '    StrReturn = "<span style='color:#8C0B08;'>" REM Red
        'ElseIf Minutes > MinimumOfficeTimmingMinute + 120 Then
        '    StrReturn = "<span style='color:#0C587A;'>" REM Blue
        'Else
        '    StrReturn = "<span style='color:#0DA015;'>" REM Green
        'End If
        'StrReturn = StrReturn & IIf(TotalHours < 10, "0" & TotalHours, TotalHours) & ":" & IIf(TotalMinutes < 10, "0" & TotalMinutes, TotalMinutes)
        'StrReturn = StrReturn & "</span>"

        Return StrReturn
    End Function

    Private Function GetTotalHours(ByVal Minutes As Integer, ByVal MinimumOfficeTimmingMinute As Integer) As String
        Dim StrReturn As String = String.Empty
        Dim TotalHours As Integer = 0
        Dim TotalMinutes As Integer = 0

        TotalMinutes = Minutes Mod 60

        TotalHours = (Minutes - TotalMinutes) / 60

        If Minutes < MinimumOfficeTimmingMinute Then
            StrReturn = "<span style='color:#8C0B08;'>" REM Red
        ElseIf Minutes >= MinimumOfficeTimmingMinute And Minutes <= MinimumOfficeTimmingMinute + 120 Then
            StrReturn = "<span style='color:#0DA015;'>" REM Green
        Else
            StrReturn = "<span style='color:#0C587A;'>" REM Blue
        End If

        StrReturn = StrReturn & IIf(TotalHours < 10, "0" & TotalHours, TotalHours) & ":" & IIf(TotalMinutes < 10, "0" & TotalMinutes, TotalMinutes)
        StrReturn = StrReturn & "</span>"

        Return StrReturn
    End Function

    Private Function GetOffDaysHtml(ByRef arrUserTempDates As System.Collections.ArrayList, ByVal ToDate As DateTime, ByVal OffSaturday As Object) As StringBuilder
        Dim StrNote As String = ""
        Dim ColorCode As String = ""
        If OffSaturday Is DBNull.Value Then
            StrNote = "ABSENT"
            ColorCode = "#EEF5FB"
        Else
            Dim dtDate As DateTime = DateTime.Parse(OffSaturday)
            If dtDate.DayOfWeek = DayOfWeek.Saturday Then
                StrNote = "OFF-SATURDAY"
                ColorCode = "#E9E4FB"
            ElseIf dtDate.DayOfWeek = DayOfWeek.Sunday Then
                StrNote = "OFFICAL-LEAVE"
                ColorCode = "#EEF5FB"
            Else
                StrNote = "ABSENT"
                ColorCode = "#EEF5FB"
            End If
        End If
        REM Check If OffSaTURDAY IS NULL THEN Absent
        REM Check If OffSaTURDAY IS Date AND Date IN SAturday Then MArk AS  OffSaturday

        Dim strReturnHtml As New StringBuilder
        strReturnHtml.Append("<div class='divOffDay' style='float: left; background-color:###COLOR####;border:solid 1px #D4DDE4; width:357px; height:40px;'><div style='text-align:center; padding-top:10px;'>###NOTE###</div></div>")
        REM strReturnHtml.Append(My.Computer.FileSystem.ReadAllText("F:\Portal\HR\HRTimeHistoryHtml\OffDaysHtml.htm"))
        strReturnHtml.Replace("###DAY###", DateTime.Parse(ToDate).ToString("ddd"))
        strReturnHtml.Replace("###DATE###", DateTime.Parse(ToDate).ToString("dd MMM, yyyy"))
        strReturnHtml.Replace("###NOTE###", StrNote)
        strReturnHtml.Replace("###COLOR####", ColorCode)

        Return strReturnHtml
    End Function

    Private Function GetOffDaysHtml(ByVal ToDate As DateTime, ByVal OffDayType As Integer) As StringBuilder
        Dim StrNote As String = ""
        Dim ColorCode As String = ""
        If OffDayType = OffDaysTypes.Absent Then
            StrNote = "ABSENT"
            ColorCode = "#EEF5FB"
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
        strReturnHtml.Append("<div class='divOffDay' style='float: left; background-color:###COLOR####;border:solid 1px #D4DDE4; width:357px; height:40px;'><div style='text-align:center; padding-top:10px;'>###NOTE###</div></div>")
        strReturnHtml.Replace("###DAY###", DateTime.Parse(ToDate).ToString("ddd"))
        strReturnHtml.Replace("###DATE###", DateTime.Parse(ToDate).ToString("dd MMM, yyyy"))
        strReturnHtml.Replace("###NOTE###", StrNote)
        strReturnHtml.Replace("###COLOR####", ColorCode)
        Return strReturnHtml
    End Function

    Private Sub DeleteDateFromTempArray(ByRef arrUserTempDates As System.Collections.ArrayList, ByVal ToDate As DateTime)
        Dim offSetIndex As Integer = 0
        Dim counter As Integer = 0
        While counter < arrUserTempDates.Count
            If DateTime.Parse(arrUserTempDates(counter)).ToShortDateString = ToDate.ToShortDateString() Then
                Dim i As Integer = 0
                While i <= counter
                    arrUserTempDates.RemoveAt(i)
                    counter = counter - 1
                End While
                Exit While
            End If
            counter = counter + 1
        End While
    End Sub

    Private Function GetEmptyDivs(ByVal Number As Integer) As String
        Dim StrHtml As String = String.Empty
        While Number < 5
            StrHtml = StrHtml + "<div class='dvTimeInTimeOut dvEmptyCell' style='float:left;'><div class='dvTimeInTimeOut_IN'>&nbsp;</div><div class='dvTimeInTimeOut_OUT'>&nbsp;</div></div>"
            Number = Number + 1
        End While
        Return StrHtml
    End Function

    Private Function GetEmptyDivsForTotalRow(ByVal Number As Integer) As String
        Dim StrHtml As String = String.Empty
        'While Number < 5
        'StrHtml = StrHtml + "<div class='dvTimeInTimeOut dvEmptyCell' style='float:left; border:solid 1px #95BEDE;  border-top:solid 0px #95BEDE; border-right:solid 0px #95BEDE;  background-color:#FCFCE2;'>&nbsp;</div>"
        'StrHtml = StrHtml + "<div class='dvTimeInTimeOut dvEmptyCell' style='float:left; border:solid 1px #95BEDE;  border-top:solid 0px #95BEDE; border-right:solid 0px #95BEDE;  background-color:#FCFCE2;'>&nbsp;</div>"
        'StrHtml = StrHtml + "<div class='dvTimeInTimeOut dvEmptyCell' style='float:left; border:solid 1px #95BEDE;  border-top:solid 0px #95BEDE; border-right:solid 0px #95BEDE;  background-color:#FCFCE2;'>&nbsp;</div>"
        'StrHtml = StrHtml + "<div class='dvTimeInTimeOut dvEmptyCell' style='float:left; border:solid 1px #95BEDE;  border-top:solid 0px #95BEDE; border-right:solid 0px #95BEDE;  background-color:#FCFCE2;'>&nbsp;</div>"
        'StrHtml = StrHtml + "<div class='dvTimeInTimeOut dvEmptyCell' style='float:left; border:solid 1px #95BEDE;  border-top:solid 0px #95BEDE; border-right:solid 0px #95BEDE;  background-color:#FCFCE2;'>&nbsp;</div>"

        StrHtml = StrHtml + "<div class='dvEmptyCellTotalRow' style='float:left; height:40px; border:solid 1px #95BEDE;  border-top:solid 0px #95BEDE; border-right:solid 0px #95BEDE;  background-color:#FCFCE2;'>&nbsp;</div>"

        Number = Number + 1
        'End While
        Return StrHtml
    End Function

    Protected Sub refreshGrid_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles refreshGrid.Click
        Me.ddlPeriod.SelectedValue = Functions.ReportDatePeriods.Last7Days
        Me.ddlPeriod.Items(7).Text = "Custom"
        Me.ddlPeriod.Width = "100"
        Me.btnGo_Click(Nothing, Nothing)
        Me.pnlmain.Update()
    End Sub

    Protected Sub ddlUsers_DataBound(ByVal o As Object, ByVal e As System.EventArgs) Handles ddlUsers.DataBound
        ddlUsers.Items.Insert(0, New Telerik.WebControls.RadComboBoxItem("Show All", 0))
    End Sub

    Protected Sub ddlUsers_ItemsRequested(ByVal o As Object, ByVal e As Telerik.WebControls.RadComboBoxItemsRequestedEventArgs) Handles ddlUsers.ItemsRequested
        Me.LoadEmployee(CType(HttpContext.Current.Session("AdminCurrentobjUser"), Portal.BLL.Users).ID, e.Text, Request("IsAdmin"))
    End Sub

    Protected Sub imgBtnChangeInterval_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgBtnChangeInterval.Click
        DateFrom.Text = Request.Form("DateFrom")
        DateTo.Text = Request.Form("DateTo")
        Me.hdnStartDate.Value = DateTime.Parse(Request.Form("DateFrom"))
        Me.hdnEndDate.Value = DateTime.Parse(Request.Form("DateTo"))
        If DateTime.Parse(hdnEndDate.Value) > DateTime.Now Then
            hdnEndDate.Value = DateTime.Now
        End If
        'hdnEndDate.Value = DateTime.Parse(hdnEndDate.Value).AddHours(Me.hdnTimeZoneHoursDIFF.Value)
	hdnEndDate.Value = DateTime.Parse(hdnEndDate.Value).AddHours(9)
        Me.ddlPeriod.Items(7).Text = "Custom " & DateTime.Parse(hdnStartDate.Value).ToString("dd/MM") & " - " & DateTime.Parse(hdnEndDate.Value).ToString("dd/MM")
        Me.ddlPeriod.Width = "130"
        Me.pnlmain.Update()
    End Sub

    Private Sub ResetTimeHistoryFlag(ByVal _IsLateArrival As Boolean, ByVal _HasEarlyDeparture As Boolean, ByVal _HasLateSitting As Boolean)
        IsLateArrival = _IsLateArrival
        HasEarlyDeparture = _HasEarlyDeparture
        HasLateSitting = _HasLateSitting
    End Sub

    Private Function ShowSundayPunchIn(ByVal ReportingDate As DateTime, _
                                       ByVal PunchInTime As Object) As Boolean
        Dim ReturnValue As Boolean = True
        If ReportingDate.DayOfWeek = DayOfWeek.Sunday Then
            If PunchInTime Is DBNull.Value Then
                ReturnValue = False
            End If
        End If
        Return ReturnValue
    End Function

    Protected Sub ddlTeams_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlTeams.DataBound
        Me.ddlTeams.Items.Insert(0, New ListItem("Show All", 0))
        REM Me.ddlTeams.SelectedValue = CType(HttpContext.Current.Session("AdminCurrentobjUser"), Portal.BLL.Users).TeamID
        If hdnIsAdmin.Value = "0" Then
            REM Me.ddlDeparments.Enabled = False
            For Each li As ListItem In ddlTeams.Items
                li.Enabled = False
            Next
            Dim DDLCounter As Integer = 0
            If Not Me.arrTeams.Length = 0 Then
                While DDLCounter < arrTeams.Length
                    If arrTeams(DDLCounter) <> String.Empty Then
                        CType(Me.ddlTeams.Items.FindByValue(arrTeams(DDLCounter)), ListItem).Enabled = True
                        CType(Me.ddlTeams.Items.FindByValue(arrTeams(DDLCounter)), ListItem).Selected = True
                    End If
                    DDLCounter = DDLCounter + 1
                End While
            End If

            If Not Me.arrTeamsUnder.Length = 0 Then
                DDLCounter = 0
                While DDLCounter < arrTeamsUnder.Length
                    If arrTeamsUnder(DDLCounter) <> String.Empty Then
                        CType(Me.ddlTeams.Items.FindByValue(arrTeamsUnder(DDLCounter)), ListItem).Enabled = True
                        CType(Me.ddlTeams.Items.FindByValue(arrTeamsUnder(DDLCounter)), ListItem).Selected = True
                        Me.ddlUsers.Enabled = True
                    End If
                    DDLCounter = DDLCounter + 1
                End While
            End If
            Dim CheckAllowdTeams As Integer = 0
            For Each li As ListItem In ddlTeams.Items
                If li.Enabled = True Then
                    CheckAllowdTeams = CheckAllowdTeams + 1
                End If
            Next
            If CheckAllowdTeams = 1 Then
                ddlTeams.Enabled = False
            Else
                ddlTeams.SelectedValue = arrTeams(0)
            End If
        Else
            Dim DDLCounter As Integer = 0
            If Not Me.arrTeams.Length = 0 Then
                While DDLCounter < arrTeams.Length
                    If arrTeams(DDLCounter) <> String.Empty Then
                        CType(Me.ddlTeams.Items.FindByValue(arrTeams(DDLCounter)), ListItem).Selected = True
                    End If
                    DDLCounter = DDLCounter + 1
                End While
            End If
        End If
    End Sub
    Protected Sub ddlUsers_SelectedIndexChanged(ByVal o As Object, ByVal e As Telerik.WebControls.RadComboBoxSelectedIndexChangedEventArgs) Handles ddlUsers.SelectedIndexChanged
        Dim arrUserInfo() As String
        Dim UserID, DepartmentID, TeamID As Integer
        arrUserInfo = Me.ddlUsers.SelectedValue.Split("&")
        UserID = IIf(String.IsNullOrEmpty(arrUserInfo(0)), 0, arrUserInfo(0))
        Me.hdnSelectedUser.Value = UserID
        If arrUserInfo.Length = 3 Then
            DepartmentID = arrUserInfo(1)
            TeamID = arrUserInfo(2)
            Me.ddlTeams.SelectedValue = TeamID
            Me.ddlDeparments.SelectedValue = DepartmentID
        End If
        Me.pnlmain.Update()
    End Sub

    Protected Sub btnGo_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnGo.Click
        Dim SelectedStartDate As DateTime = DateTime.Now
        Me.ddlPeriod.Items(7).Text = "Custom"
        Me.ddlPeriod.Width = "100"
        If ddlPeriod.SelectedValue = Functions.ReportDatePeriods.Today Then
            Me.hdnStartDate.Value = DateTime.Now.ToShortDateString()
            'Me.hdnEndDate.Value = DateTime.Now.AddHours(Me.hdnTimeZoneHoursDIFF.Value)
	    Me.hdnEndDate.Value = DateTime.Now.AddHours(9)
        ElseIf ddlPeriod.SelectedValue = Functions.ReportDatePeriods.Yesterday Then
            If DateTime.Now.AddDays(-1).Day = DayOfWeek.Sunday Then
                Me.hdnStartDate.Value = DateTime.Now.AddDays(-2).ToShortDateString()
                Me.hdnEndDate.Value = DateTime.Now.AddDays(-2).ToShortDateString()
            Else
                Me.hdnStartDate.Value = DateTime.Now.AddDays(-1).ToShortDateString()
                Me.hdnEndDate.Value = DateTime.Now.AddDays(-1).ToShortDateString()
            End If
        ElseIf ddlPeriod.SelectedValue = Functions.ReportDatePeriods.ThisWeek Then
        While SelectedStartDate.DayOfWeek <> DayOfWeek.Monday
            SelectedStartDate = SelectedStartDate.AddDays(-1)
        End While
        Me.hdnStartDate.Value = SelectedStartDate.ToShortDateString()
            'Me.hdnEndDate.Value = DateTime.Now.AddHours(Me.hdnTimeZoneHoursDIFF.Value)

	    Me.hdnEndDate.Value = DateTime.Now.AddHours(9)
	
        ElseIf ddlPeriod.SelectedValue = Functions.ReportDatePeriods.LastWeek Then
        SelectedStartDate = SelectedStartDate.AddDays(-14)
        While SelectedStartDate.DayOfWeek <> DayOfWeek.Monday
            SelectedStartDate = SelectedStartDate.AddDays(1)
        End While
        Me.hdnStartDate.Value = SelectedStartDate.ToShortDateString()
            'Me.hdnEndDate.Value = DateTime.Now.AddHours(Me.hdnTimeZoneHoursDIFF.Value)
            Me.hdnEndDate.Value = DateTime.Now.AddHours(9)
        ElseIf ddlPeriod.SelectedValue = Functions.ReportDatePeriods.Last7Days Then
        SelectedStartDate = SelectedStartDate.AddDays(-7)
        Me.hdnStartDate.Value = SelectedStartDate.ToShortDateString()
            'Me.hdnEndDate.Value = DateTime.Now.AddHours(Me.hdnTimeZoneHoursDIFF.Value)
            Me.hdnEndDate.Value = DateTime.Now.AddHours(9)
        ElseIf ddlPeriod.SelectedValue = Functions.ReportDatePeriods.ThisMonth Then
            SelectedStartDate = DateTime.Now.AddMonths(-1)
            While SelectedStartDate.Month <> DateTime.Now.Month
                SelectedStartDate = SelectedStartDate.AddDays(1)
            End While
            Me.hdnStartDate.Value = SelectedStartDate.ToShortDateString()
            'Me.hdnEndDate.Value = DateTime.Now.AddHours(Me.hdnTimeZoneHoursDIFF.Value)
            Me.hdnEndDate.Value = DateTime.Now.AddHours(9)
        ElseIf ddlPeriod.SelectedValue = Functions.ReportDatePeriods.LastMonth Then
            SelectedStartDate = DateTime.Now.AddMonths(-2)
            While SelectedStartDate.Month <> IIf(DateTime.Now.Month - 1 = 0, 12, DateTime.Now.Month - 1)
                SelectedStartDate = SelectedStartDate.AddDays(1)
            End While
            Me.hdnStartDate.Value = SelectedStartDate.ToShortDateString()
            'Me.hdnEndDate.Value = DateTime.Now.AddHours(Me.hdnTimeZoneHoursDIFF.Value)
	    Me.hdnEndDate.Value = DateTime.Now.AddHours(9)

        ElseIf ddlPeriod.SelectedValue = Functions.ReportDatePeriods.Custom Then
        DateFrom.Text = Request.Form("DateFrom")
        DateTo.Text = Request.Form("DateTo")
        Me.hdnStartDate.Value = DateTime.Parse(Request.Form("DateFrom"))
        Me.hdnEndDate.Value = DateTime.Parse(Request.Form("DateTo"))
        If DateTime.Parse(hdnEndDate.Value) > DateTime.Now Then
                'hdnEndDate.Value = DateTime.Now.AddHours(Me.hdnTimeZoneHoursDIFF.Value)
		 hdnEndDate.Value = DateTime.Now.AddHours(9)
        End If
        Me.ddlPeriod.Items(7).Text = "Custom " & DateTime.Parse(hdnStartDate.Value).ToString("dd/MM") & " - " & DateTime.Parse(hdnEndDate.Value).ToString("dd/MM")
        Me.ddlPeriod.Width = "130"
        End If
        Me.pnlmain.Update()
    End Sub
End Class
