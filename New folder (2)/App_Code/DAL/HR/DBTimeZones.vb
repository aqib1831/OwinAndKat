Imports Microsoft.VisualBasic


Namespace Portal.DAL.HR
    Public Class DBTimeZones
        Public Shared Function TimeZoneGetByID(ByVal TimeZoneID As Integer) As Integer
            Dim db As New DBAccess
            Dim HoursOffSet As Integer = 0
            db.AddParameter("@ID", TimeZoneID)
            HoursOffSet = db.ExecuteScalar("TimeZones_GetByID")
            db.Dispose()
            Return HoursOffSet
        End Function
    End Class
End Namespace
