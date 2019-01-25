Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data
Imports Functions
Namespace Portal.DAL.HR
    Public Class DBHR_UserTimeHistory
#Region " Public Method "
        Public Shared Function HR_UserTimeHistoryGetAll(ByVal UserID As Integer, ByVal FromDate As Date, ByVal ToDate As Date, ByVal sortExpression As String, ByVal maximumRows As Integer, ByVal startRowIndex As Integer, ByVal txtsearch As String) As List(Of Portal.BLL.HR.HR_UserTimeHistory)
            Dim colHR_UserTimeHistory As New List(Of Portal.BLL.HR.HR_UserTimeHistory)()
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@UserID", UserID)
            db.AddParameter("@FromDate", FromDate)
            db.AddParameter("@ToDate", ToDate)
            db.AddParameter("@sortExpression", sortExpression)
            db.AddParameter("@startRowIndex", startRowIndex)
            db.AddParameter("@maximumRows", maximumRows)
            dr = db.ExecuteReader("HR_UserTimeHistory_GetAll")
            While dr.Read()
                colHR_UserTimeHistory.Add(New Portal.BLL.HR.HR_UserTimeHistory( _
                CType(dr("ID"), Integer), _
                CType(dr("UserID"), Integer), _
                CType(dr("PunchInTime"), Date), _
                CType(dr("PunchOutTime"), Date), _
                CType(dr("LastAccessTime"), Date), _
                CType(dr("ForcedPunchOut"), Boolean), _
                CType(dr("Notes"), String), _
                CType(dr("Deleted"), Boolean), _
                CType(dr("LastUpdatedBy"), Integer), _
                CType(dr("LastUpdatedNotes"), String), _
                CType(dr("CreationType"), Integer), _
                CType(dr("LastUpdatedAdminName"), String), _
                CType(dr("CurrentHours"), Integer), _
                CType(dr("CurrentMinutes"), Integer), _
                CType(dr("TotalMinutes"), Integer) _
                ))
            End While
            dr.Close()
            Return colHR_UserTimeHistory
        End Function

        Public Shared Function HR_UserTimeHistoryGetAllCount(ByVal UserID As Integer, ByVal FromDate As Date, ByVal ToDate As Date, ByVal sortExpression As String, ByVal txtsearch As String) As Integer
            Dim db As New DBAccess
            db.AddParameter("@UserID", UserID)
            db.AddParameter("@FromDate", FromDate)
            db.AddParameter("@ToDate", ToDate)
            Return CInt(db.ExecuteScalar("HR_UserTimeHistory_GetAllCount"))
        End Function

        
        Public Shared Function HR_UserTimeHistoryGetByID(ByVal ID As Integer) As List(Of Portal.BLL.HR.HR_UserTimeHistory)
            Dim colHR_UserTimeHistory As New List(Of Portal.BLL.HR.HR_UserTimeHistory)()
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            dr = db.ExecuteReader("HR_UserTimeHistory_GetByID")
            While dr.Read()
                colHR_UserTimeHistory.Add(New Portal.BLL.HR.HR_UserTimeHistory( _
                CType(dr("ID"), Integer), _
                CType(dr("UserID"), Integer), _
                CType(dr("PunchInTime"), Date), _
                CType(dr("PunchOutTime"), Date), _
                CType(dr("LastAccessTime"), Date), _
                CType(dr("ForcedPunchOut"), Boolean), _
                CType(dr("Notes"), String), _
                CType(dr("Deleted"), Boolean), _
                CType(dr("LastUpdatedBy"), Integer), _
                CType(dr("LastUpdatedNotes"), String), _
                CType(dr("CreationType"), Integer), _
                CType(dr("AttendenceType"), Integer) _
                ))
            End While
            dr.Close()
            Return colHR_UserTimeHistory
        End Function
        Public Shared Function HR_UserTimeHistoryGetByUserID(ByVal UserID As Integer) As List(Of Portal.BLL.HR.HR_UserTimeHistory)
            Dim colHR_UserTimeHistory As New List(Of Portal.BLL.HR.HR_UserTimeHistory)()
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@ID", UserID)
            dr = db.ExecuteReader("HR_UserTimeHistory_Latest") 'HR_UserTimeHistory_GetByID
            While dr.Read()
                colHR_UserTimeHistory.Add(New Portal.BLL.HR.HR_UserTimeHistory( _
                CType(dr("ID"), Integer), _
                CType(IfNull(dr("UserID"), 0), Integer), _
                CType(IfNull(dr("PunchInTime"), Nothing), Date), _
                CType(IfNull(dr("PunchOutTime"), Nothing), Date), _
                CType(IfNull(dr("LastAccessTime"), Nothing), Date), _
                CType(dr("ForcedPunchOut"), Boolean), _
                CType(IfNull(dr("Notes"), ""), String), _
                CType(dr("Deleted"), Boolean), _
                CType(IfNull(dr("LastUpdatedBy"), 0), Integer), _
                CType(IfNull(dr("LastUpdatedNotes"), ""), String), _
                CType(IfNull(dr("CreationType"), 0), Integer), _
                CType(dr("AttendenceType"), Integer) _
                ))
            End While
            dr.Close()
            Return colHR_UserTimeHistory
        End Function
        Public Function Add(ByVal HR_UserTimeHistoryBll As Portal.BLL.HR.HR_UserTimeHistory) As Integer
            Dim db As New DBAccess

            'db.AddParameter("@ID", HR_UserTimeHistoryBll.ID)
            db.AddParameter("@UserID", HR_UserTimeHistoryBll.UserID)
            db.AddParameter("@PunchInTime", HR_UserTimeHistoryBll.PunchInTime)
            db.AddParameter("@PunchOutTime", IIf(DateTime.Parse(DateTime.MaxValue) = HR_UserTimeHistoryBll.PunchOutTime, DBNull.Value ,HR_UserTimeHistoryBll.PunchOutTime))
            db.AddParameter("@LastAccessTime", HR_UserTimeHistoryBll.LastAccessTime)
            db.AddParameter("@ForcedPunchOut", HR_UserTimeHistoryBll.ForcedPunchOut)
            'db.AddParameter("@Notes", HR_UserTimeHistoryBll.Notes)
            db.AddParameter("@Deleted", HR_UserTimeHistoryBll.Deleted)
            db.AddParameter("@LastUpdatedBy", HR_UserTimeHistoryBll.LastUpdatedBy)
            db.AddParameter("@LastUpdatedNotes", HR_UserTimeHistoryBll.LastUpdatedNotes)
            db.AddParameter("@CreationType", HR_UserTimeHistoryBll.CreationType)
            db.AddParameter("@UserOfficeTimingProfileID", HR_UserTimeHistoryBll.UserOfficeTimingProfileID)
            db.AddParameter("@LateArrival", HR_UserTimeHistoryBll.LateArrival)
            db.AddParameter("@EarlyDeparture", HR_UserTimeHistoryBll.EarlyDeparture)
            db.AddParameter("@LateSitting", HR_UserTimeHistoryBll.LateSitting)
            db.AddParameter("@LateArrivalNotes", IIf(HR_UserTimeHistoryBll.LateArrivalNotes = String.Empty, DBNull.Value, HR_UserTimeHistoryBll.LateArrivalNotes))
            db.AddParameter("@EarlyDepartureNotes", IIf(HR_UserTimeHistoryBll.EarlyDepartureNotes = String.Empty, DBNull.Value, HR_UserTimeHistoryBll.EarlyDepartureNotes))
            db.AddParameter("@LateSittingNotes", IIf(HR_UserTimeHistoryBll.LateSittingNotes = String.Empty, DBNull.Value, HR_UserTimeHistoryBll.LateSittingNotes))
            db.AddParameter("@AttendenceType", IIf(HR_UserTimeHistoryBll.AttendenceType = 0, DBNull.Value, HR_UserTimeHistoryBll.AttendenceType))
            db.AddParameter("@RecordID", System.Data.SqlDbType.BigInt, 8, ParameterDirection.Output, 0)
            Dim Affected As Integer = db.ExecuteScalar("HR_UserTimeHistory_Add")
            Return Affected
        End Function

        Public Function Update(ByVal HR_UserTimeHistoryBll As Portal.BLL.HR.HR_UserTimeHistory) As Integer
            Dim db As New DBAccess

            db.AddParameter("@ID", HR_UserTimeHistoryBll.ID)
            'db.AddParameter("@UserID", HR_UserTimeHistoryBll.UserID)
            db.AddParameter("@PunchInTime", HR_UserTimeHistoryBll.PunchInTime)
            db.AddParameter("@PunchOutTime", IIf(DateTime.Parse(DateTime.MaxValue) = HR_UserTimeHistoryBll.PunchOutTime, DBNull.Value, HR_UserTimeHistoryBll.PunchOutTime))
            'db.AddParameter("@LastAccessTime", HR_UserTimeHistoryBll.LastAccessTime)
            db.AddParameter("@ForcedPunchOut", HR_UserTimeHistoryBll.ForcedPunchOut)
            'db.AddParameter("@Notes", HR_UserTimeHistoryBll.Notes)
            'db.AddParameter("@Deleted", HR_UserTimeHistoryBll.Deleted)
            db.AddParameter("@LastUpdatedBy", HR_UserTimeHistoryBll.LastUpdatedBy)
            db.AddParameter("@LastUpdatedNotes", HR_UserTimeHistoryBll.LastUpdatedNotes)
            db.AddParameter("@CreationType", HR_UserTimeHistoryBll.CreationType)
            db.AddParameter("@UserOfficeTimingProfileID", HR_UserTimeHistoryBll.UserOfficeTimingProfileID)
            db.AddParameter("@LateArrival", HR_UserTimeHistoryBll.LateArrival)
            db.AddParameter("@EarlyDeparture", HR_UserTimeHistoryBll.EarlyDeparture)
            db.AddParameter("@LateSitting", HR_UserTimeHistoryBll.LateSitting)
            db.AddParameter("@LateArrivalNotes", IIf(HR_UserTimeHistoryBll.LateArrivalNotes = String.Empty, DBNull.Value, HR_UserTimeHistoryBll.LateArrivalNotes))
            db.AddParameter("@EarlyDepartureNotes", IIf(HR_UserTimeHistoryBll.EarlyDepartureNotes = String.Empty, DBNull.Value, HR_UserTimeHistoryBll.EarlyDepartureNotes))
            db.AddParameter("@LateSittingNotes", IIf(HR_UserTimeHistoryBll.LateSittingNotes = String.Empty, DBNull.Value, HR_UserTimeHistoryBll.LateSittingNotes))
            db.AddParameter("@AttendenceType", IIf(HR_UserTimeHistoryBll.AttendenceType = 0, DBNull.Value, HR_UserTimeHistoryBll.AttendenceType))
            Dim Affected As Integer = db.ExecuteNonQuery("HR_UserTimeHistory_Update")
            Return Affected
        End Function

        Public Shared Function HR_UserTimeHistoryCheckTimeDuration(ByVal ID As Integer, ByVal UserID As Integer, ByVal objDate As Date) As DataTable
            Dim db As New DBAccess
            Dim dtResult As New DataTable()
            Dim objHR_UserTimeHistory As New Portal.BLL.HR.HR_UserTimeHistory
            db.AddParameter("@ID", ID)
            db.AddParameter("@UserID", UserID)
            db.AddParameter("@Date", objDate)
            dtResult = db.ExecuteDataTable("HR_UserTimeHistory_GetPunchInsForUser")
            Return dtResult
        End Function

        Public Shared Function HR_GetTimeZoneOffSetByUserID(ByVal ID As Integer) As Portal.BLL.Users
            Dim colHR_Users As New Portal.BLL.Users
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@Users", ID)
            dr = db.ExecuteReader("TimeZone_GetByUserID")
            While dr.Read()
                colHR_Users.TeamID = CType(dr("TeamID"), Integer)
                colHR_Users.TimeZoneID = CType(dr("TimeZoneOffSet"), Integer)
            End While
            dr.Close()
            Return colHR_Users
        End Function

	 Public Shared Function GetLateArrivalAndAbsentReportByDate(ByVal reportDate As Date, ByVal isForSupport As Boolean) As DataTable
            Dim objDbAccess As New DBAccess
            objDbAccess.AddParameter("@ReportDate", reportDate)
            objDbAccess.AddParameter("@IsSupport", isForSupport)
            Return objDbAccess.ExecuteDataTable("Users_GetAbsentAndLateArrivalsByDate")
        End Function
	
		Public Shared Function GetEmployeesTimeHistoryDetail(ByVal StartDate As DateTime, _
                                                             ByVal EndDate As DateTime, _
                                                             ByVal DepartmentID As Integer, _
                                                             ByVal TeamID As Integer, _
                                                             ByVal EmployeeID As Integer, _
                                                             ByVal Status As Integer) As System.Data.DataTable
            Dim db As New DBAccess()
            db.AddParameter("@StartDate", StartDate)
            db.AddParameter("@EndDate", EndDate)
            If DepartmentID > 0 Then
                db.AddParameter("@DepartmentID", DepartmentID)
            Else
                db.AddParameter("@DepartmentID", DBNull.Value)
            End If
            If TeamID > 0 Then
                db.AddParameter("@TeamID", TeamID)
            Else
                db.AddParameter("@TeamID", DBNull.Value)
            End If
            If EmployeeID > 0 Then
                db.AddParameter("@EmployeeID", EmployeeID)
            Else
                db.AddParameter("@EmployeeID", DBNull.Value)
            End If
            If Status > 0 Then
                db.AddParameter("@Status", Status)
            Else
                db.AddParameter("@Status", DBNull.Value)
            End If

            Return db.ExecuteDataTable("HR_GetAttendenceDetail")
        End Function

Public Shared Function GetEmployeesTimeHistoryDetail_Printable(ByVal StartDate As DateTime, _
                                                             ByVal EndDate As DateTime, _
                                                             ByVal DepartmentID As Integer, _
                                                             ByVal TeamID As Integer, _
                                                             ByVal EmployeeID As Integer, _
                                                             ByVal Status As Integer) As System.Data.DataSet
            Dim db As New DBAccess()
            Dim dsAttendence As New System.Data.DataSet
            db.AddParameter("@StartDate", StartDate)
            db.AddParameter("@EndDate", EndDate)
            If DepartmentID > 0 Then
                db.AddParameter("@DepartmentID", DepartmentID)
            Else
                db.AddParameter("@DepartmentID", DBNull.Value)
            End If
            If TeamID > 0 Then
                db.AddParameter("@TeamID", TeamID)
            Else
                db.AddParameter("@TeamID", DBNull.Value)
            End If
            If EmployeeID > 0 Then
                db.AddParameter("@EmployeeID", EmployeeID)
            Else
                db.AddParameter("@EmployeeID", DBNull.Value)
            End If
            If Status > 0 Then
                db.AddParameter("@Status", Status)
            Else
                db.AddParameter("@Status", DBNull.Value)
            End If
            dsAttendence = db.ExecuteDataSet("HR_GetAttendenceDetail_Printable")
            dsAttendence.Tables(0).TableName = "Users"
            dsAttendence.Tables(1).TableName = "Attendence"
            dsAttendence.Relations.Add("Users_Attendence", dsAttendence.Tables("Users").Columns("UserID"), dsAttendence.Tables("Attendence").Columns("UserID"), False)
            Return dsAttendence
        End Function
				
        Public Shared Function CalculateAnnualLeaves(ByVal RecordID As Integer, _
                                              ByVal EmployeeID As Integer) As Integer
            Dim ReturnVal As Integer = 0
            Dim db As New DBAccess()
            db.AddParameter("@RecordID", RecordID)
            db.AddParameter("@EmployeeID", EmployeeID)
            ReturnVal = db.ExecuteNonQuery("HR_UserTimeHIstory_CalculateLeaves")
            Return ReturnVal
        End Function

#End Region

    End Class
End Namespace