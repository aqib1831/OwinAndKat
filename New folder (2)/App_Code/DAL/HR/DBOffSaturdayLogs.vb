Imports Microsoft.VisualBasic


Namespace Portal.DAL.HR
    Public Class DBOffSaturdayLogs
        Public Shared Sub AddUserToOffSaturdayGroupLogs(ByVal UserID As Integer, _
                                                        ByVal DateOn As DateTime, _
                                                        ByVal GroupType As Integer)
            Dim db As New DBAccess()
            db.AddParameter("@UserID", UserID)
            db.AddParameter("@DateOn", DateOn)
            db.AddParameter("@GroupType", IIf(GroupType = 0, DBNull.Value, GroupType))
            db.AddParameter("@UpdatedBy", CType(HttpContext.Current.Session("AdminCurrentobjUser"), Portal.BLL.Users).ID)
            db.ExecuteNonQuery("HR_OffSaturdaySchedulesLogs_Add")
        End Sub
    End Class
End Namespace

