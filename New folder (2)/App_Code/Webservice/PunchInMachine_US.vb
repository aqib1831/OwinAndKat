Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Data
Imports System.Web.HttpUtility

<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class PunchInMachine_US
    Inherits System.Web.Services.WebService

    <WebMethod()> _
    Public Function GetTimeZones(ByVal LastSyncDate As DateTime) As Byte()
        If ValidateIP() Then
            Dim db As New DBAccess
            Dim dsUsers As New System.Data.DataSet
            db.AddParameter("@LastSyncronizationDate", IIf(LastSyncDate = DateTime.MinValue, DBNull.Value, LastSyncDate))
            dsUsers = db.ExecuteDataSet("TimeZone_GetAll")
            Functions.AddUTCOffset(dsUsers)
            db.Dispose()
            Return Functions.CompressDataSet(dsUsers)
        Else
            Return Nothing
        End If
    End Function

    <WebMethod()> _
    Public Function GetGroups(ByVal LastSyncDate As DateTime) As Byte()
        If ValidateIP() Then
            Dim db As New DBAccess()
            Dim dsUsers As New System.Data.DataSet
            db.AddParameter("@LastSyncronizationDate", IIf(LastSyncDate = DateTime.MinValue, DBNull.Value, LastSyncDate))
            dsUsers = db.ExecuteDataSet("Groups_GetAllForLocalPunchInDBSync")
            Functions.AddUTCOffset(dsUsers)
            db.Dispose()
            Return Functions.CompressDataSet(dsUsers)
        Else
            Return Nothing
        End If
    End Function

    <WebMethod()> _
    Public Function GetUpdatedUsersForPunchInMachine(ByVal LastSyncDate As DateTime, ByVal OfficeID As Integer) As Byte()
        If ValidateIP() Then
            Dim dsUsers As New System.Data.DataSet
            dsUsers = Portal.DAL.DBUsers.GetLatestUpdatedUsersDataForPunchInMachine(LastSyncDate, OfficeID)
            Functions.AddUTCOffset(dsUsers)
            Return Functions.CompressDataSet(dsUsers)
        Else
            Return Nothing
        End If

    End Function

    <WebMethod()> _
    Public Function GetLocalTime(ByVal CountryId As Integer) As String
        Dim LocalTime As DateTime = DateTime.MinValue
        Dim strIPs As String = CStr(ConfigurationManager.AppSettings("NetsolaceUSIP"))
        If CountryId = 1 Then
            strIPs = CStr(ConfigurationManager.AppSettings("NetsolaceUSIP"))

            Dim strIPArray As String() = strIPs.Split(",")
            For i As Integer = 0 To strIPArray.Length - 1
                If strIPArray(i).Trim() = HttpContext.Current.Request.UserHostAddress.ToString().Trim() Then
                    LocalTime = Functions.GetTimeByZone(ConfigurationManager.AppSettings("NetsolaeUSTimeOffset"), Now)
                End If
            Next
        End If
        Return CStr(LocalTime)
    End Function

    <WebMethod()> _
    Public Function GetUserGroupInformation(ByVal LastSyncDate As DateTime) As Byte()
        If ValidateIP() Then
            Dim db As New DBAccess()
            db.AddParameter("@LastSyncronizationDate", IIf(LastSyncDate = DateTime.MinValue, DBNull.Value, LastSyncDate))
            Dim dsUsers As New System.Data.DataSet
            dsUsers = db.ExecuteDataSet("UsersGroups_GetAll")
            Functions.AddUTCOffset(dsUsers)
            db.Dispose()
            Return Functions.CompressDataSet(dsUsers)
        Else
            Return Nothing
        End If
    End Function

    <WebMethod()> _
    Public Function GetAttendenceRecords(ByVal LastSyncronizationDate As DateTime, ByVal OfficeID As Integer) As Byte()
        If ValidateIP() Then
            Dim db As New DBAccess
            Dim dsAttendenceRecords As New System.Data.DataSet
            db.AddParameter("@LastSyncDate", LastSyncronizationDate)
            db.AddParameter("@OfficeID", OfficeID)
            dsAttendenceRecords = db.ExecuteDataSet("HR_UserTimeHistory_GetRecordsForLocalDBSync")
            Functions.AddUTCOffset(dsAttendenceRecords)
            Return Functions.CompressDataSet(dsAttendenceRecords)
        Else
            Return Nothing
        End If
    End Function

    <WebMethod()> _
    Public Function SyncronizeTimeRecordsOnLine(ByVal UnSyncdAttendenceRecords As Byte()) As Byte()
        If ValidateIP() Then
            Dim ReturnVal As Integer = 0
            Dim dsTimeRecordIDs As New System.Data.DataSet
            Dim dtTimeRecordIDs As New System.Data.DataTable()
            Dim drTimeRecordIDs As System.Data.DataRow
            dtTimeRecordIDs.Columns.Add("LocalID", Type.GetType("System.Int64"))
            dtTimeRecordIDs.Columns.Add("LiveID", Type.GetType("System.Int64"))
            Dim dsUnsyncedAttendenceRecords As New DataSet
            Try
                dsUnsyncedAttendenceRecords = Functions.DecompressDataSet(UnSyncdAttendenceRecords)
                Functions.AdjustDSTimeZone(dsUnsyncedAttendenceRecords.ExtendedProperties, dsUnsyncedAttendenceRecords.Tables(0), "PunchInTime")
                Functions.AdjustDSTimeZone(dsUnsyncedAttendenceRecords.ExtendedProperties, dsUnsyncedAttendenceRecords.Tables(0), "PunchOutTime")
                If dsUnsyncedAttendenceRecords.Tables(0) Is Nothing = False Then
                    If dsUnsyncedAttendenceRecords.Tables(0).Rows.Count > 0 Then
                        For Each drRow As DataRow In dsUnsyncedAttendenceRecords.Tables(0).Rows
                            drTimeRecordIDs = dtTimeRecordIDs.NewRow()
                            Dim objSyncTimeRecords As New HR_SyncTimeRecords()
                            Dim objTimeHistoryRecord As New Portal.BLL.HR.HR_UserTimeHistory()
                            drTimeRecordIDs(0) = drRow("ID")
                            drTimeRecordIDs(1) = IIf(drRow("LiveRecordID") Is DBNull.Value, 0, drRow("LiveRecordID"))
                            objTimeHistoryRecord.ID = IIf(drRow("LiveRecordID") Is DBNull.Value, 0, drRow("LiveRecordID"))
                            objTimeHistoryRecord.UserID = drRow("UserID")
                            objTimeHistoryRecord.PunchInTime = drRow("PunchInTime")
                            objTimeHistoryRecord.PunchOutTime = IIf(drRow("PunchOutTime") Is DBNull.Value, DateTime.Parse(DateTime.MaxValue), drRow("PunchOutTime"))
                            objTimeHistoryRecord.LastAccessTime = DateTime.Now
                            objTimeHistoryRecord.ForcedPunchOut = False
                            objTimeHistoryRecord.Notes = String.Empty
                            objTimeHistoryRecord.LastUpdatedBy = 0
                            objTimeHistoryRecord.LastUpdatedNotes = String.Empty
                            objTimeHistoryRecord.CreationType = 1
                            objTimeHistoryRecord.UserOfficeTimingProfileID = drRow("UserOfficeTimingProfileID")
                            objTimeHistoryRecord.LateArrival = drRow("LateArrival")
                            objTimeHistoryRecord.EarlyDeparture = drRow("EarlyDeparture")
                            objTimeHistoryRecord.LateSitting = drRow("LateSitting")
                            objTimeHistoryRecord.LateArrivalNotes = IIf(drRow("LateArrivalNotes") Is DBNull.Value, String.Empty, drRow("LateArrivalNotes"))
                            objTimeHistoryRecord.EarlyDepartureNotes = IIf(drRow("EarlyDepartureNotes") Is DBNull.Value, String.Empty, drRow("EarlyDepartureNotes"))
                            objTimeHistoryRecord.LateSittingNotes = IIf(drRow("LateSittingNotes") Is DBNull.Value, String.Empty, drRow("LateSittingNotes"))

                            If drTimeRecordIDs(1) = 0 Then
                                drTimeRecordIDs(1) = objSyncTimeRecords.SyncronizeTimeRecordsOnline(objTimeHistoryRecord)
                            Else
                                objSyncTimeRecords.SyncronizeTimeRecordsOnline(objTimeHistoryRecord)
                            End If

                            objSyncTimeRecords.Dispose()
                            dtTimeRecordIDs.Rows.Add(drTimeRecordIDs)
                        Next
                    End If
                End If
                dsTimeRecordIDs.Tables.Add(dtTimeRecordIDs)
            Catch ex As Exception
            End Try

            Return Functions.CompressDataSet(dsTimeRecordIDs)
        Else
            Return Nothing
        End If


    End Function

    <WebMethod()> _
    Public Function GetShiffProfiles(ByVal LastSyncDate As DateTime) As Byte()
        If ValidateIP() Then
            Dim db As New DBAccess()
            Dim dsProfiles As New DataSet()
            db.AddParameter("@LastSyncronizationDate", IIf(LastSyncDate = DateTime.MinValue, DBNull.Value, LastSyncDate))
            dsProfiles = db.ExecuteDataSet("UserOfficeTimingProfile_GetAll")
            Functions.AddUTCOffset(dsProfiles)
            db.Dispose()
            Return Functions.CompressDataSet(dsProfiles)
        Else
            Return Nothing
        End If
    End Function

    Private Function ValidateIP() As Boolean
        REM to do make it false 
        Dim ReturnVal As Boolean = True

        Dim strIPs As String = CStr(ConfigurationManager.AppSettings("NetsolaceIsbIP"))
        Dim strIPArray As String() = strIPs.Split(",")
        For i As Integer = 0 To strIPArray.Length - 1
            If strIPArray(i).Trim() = HttpContext.Current.Request.UserHostAddress.ToString().Trim() Then
                ReturnVal = True
            End If
        Next
        Return ReturnVal
    End Function


End Class
