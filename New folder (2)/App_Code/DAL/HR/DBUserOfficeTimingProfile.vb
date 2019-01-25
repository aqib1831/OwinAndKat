Imports Microsoft.VisualBasic
Imports Portal.BLL.HR

Namespace Portal.DAL.HR
    Public Class DBUserOfficeTimingProfile

        Public Shared Function AddOfficeTimingProfile(ByVal objOfficeProfile As UserOfficeTimingProfiles) As Integer
            Dim ReturnVal As Integer = 0
            Dim db As New DBAccess()
            db.AddParameter("Name", objOfficeProfile.Name)
            db.AddParameter("GraceStartTime", objOfficeProfile.GraceStartTime)
            db.AddParameter("GraceEndTime", objOfficeProfile.GraceEndTime)
            db.AddParameter("BreakStartTime", objOfficeProfile.BreakStartTime)
            db.AddParameter("BreakEndTime", objOfficeProfile.BreakEndTime)
            db.AddParameter("BreakGraceTimeStart", objOfficeProfile.BreakGraceTimeStart)
            db.AddParameter("BreakGraceTimeEnd", objOfficeProfile.BreakGraceTimeEnd)
            db.AddParameter("IsActive", objOfficeProfile.IsActive)
            db.AddParameter("Deleted", objOfficeProfile.Deleted)
            db.AddParameter("StartDateTime", objOfficeProfile.StartDateTime)
            db.AddParameter("EndDateTime", objOfficeProfile.EndDateTime)
            db.AddParameter("SaturdayOfficeStartTime", objOfficeProfile.SaturdayOfficeStartTime)
            db.AddParameter("SaturdayOfficeEndTime", objOfficeProfile.SaturdayOfficeEndTime)
            db.AddParameter("SaturdayGraceStartTime", objOfficeProfile.SaturdayGraceStartTime)
            db.AddParameter("SaturdayGraceEndTime", objOfficeProfile.SaturdayGraceEndTime)
            
            ReturnVal = db.ExecuteNonQuery("UserOfficeTimmingProfile_Add")
            Return ReturnVal
        End Function

        Public Shared Function UpdateOfficeTimingProfile(ByVal objOfficeProfile As UserOfficeTimingProfiles) As Integer
            Dim ReturnVal As Integer = 0
            Dim db As New DBAccess()
            db.AddParameter("ID", objOfficeProfile.ID)
            db.AddParameter("Name", objOfficeProfile.Name)
            db.AddParameter("GraceStartTime", objOfficeProfile.GraceStartTime)
            db.AddParameter("GraceEndTime", objOfficeProfile.GraceEndTime)
            db.AddParameter("BreakStartTime", objOfficeProfile.BreakStartTime)
            db.AddParameter("BreakEndTime", objOfficeProfile.BreakEndTime)
            db.AddParameter("BreakGraceTimeStart", objOfficeProfile.BreakGraceTimeStart)
            db.AddParameter("BreakGraceTimeEnd", objOfficeProfile.BreakGraceTimeEnd)
            db.AddParameter("IsActive", objOfficeProfile.IsActive)
            db.AddParameter("Deleted", objOfficeProfile.Deleted)
            db.AddParameter("StartDateTime", objOfficeProfile.StartDateTime)
            db.AddParameter("EndDateTime", objOfficeProfile.EndDateTime)
            db.AddParameter("SaturdayOfficeStartTime", objOfficeProfile.SaturdayOfficeStartTime)
            db.AddParameter("SaturdayOfficeEndTime", objOfficeProfile.SaturdayOfficeEndTime)
            db.AddParameter("SaturdayGraceStartTime", objOfficeProfile.SaturdayGraceStartTime)
            db.AddParameter("SaturdayGraceEndTime", objOfficeProfile.SaturdayGraceEndTime)
            db.AddParameter("UpdatedBy", objOfficeProfile.UpdatedBy)
            ReturnVal = db.ExecuteNonQuery("UserOfficeTimmingProfile_Update")
            Return ReturnVal
        End Function

        Public Shared Function DeleteOfficeTimingProfile(ByVal ProfileID As Integer) As Integer
            Dim ReturnVal As Integer = 0
            Dim db As New DBAccess()
            db.AddParameter("ID", ProfileID)
            ReturnVal = db.ExecuteNonQuery("UserOfficeTimmingProfile_Delete")
            Return ReturnVal
        End Function

        Public Shared Function ViewAllOfficeTimingProfile() As System.Data.DataTable
            Dim db As New DBAccess()
            Return db.ExecuteDataTable("UserOfficeTimmingProfile_GetAll")
        End Function

        Public Shared Function OfficeTimingProfileCount() As System.Data.DataTable
            Dim db As New DBAccess()
            Return db.ExecuteDataTable("UserOfficeTimmingProfile_Count")
        End Function

        Public Shared Function GetOfficeTimingProfileByID(ByVal objOfficeProfile As UserOfficeTimingProfiles) As System.Data.DataTable
            Dim db As New DBAccess()
            db.AddParameter("ID", objOfficeProfile.ID)
            Return db.ExecuteDataTable("UserOfficeTimmingProfile_GetByID")
        End Function

        Public Shared Function OfficeTimingProfileGetByUserID(ByVal UserID As Integer) As System.Data.DataTable
            Dim db As New DBAccess()
            db.AddParameter("UserID", UserID)
            Return db.ExecuteDataTable("UserOfficeTimingProfile_GetByUserID")
        End Function


    End Class
End Namespace

