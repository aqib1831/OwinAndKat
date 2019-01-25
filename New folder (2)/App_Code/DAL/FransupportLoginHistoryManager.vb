Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data


Namespace Portal.DAL

    Public Class FransupportLoginHistoryManager

        Public Shared Function Add(ByVal objFransupportLoginHistory As Portal.BLL.FransupportLoginHistory) As Integer

            Dim db As New DBAccess

            db.AddParameter("@AdminId", SqlDbType.Int, 8, ParameterDirection.Input, objFransupportLoginHistory.AdminId)
            db.AddParameter("@FransupportEnd", SqlDbType.tinyint, 4, ParameterDirection.Input, objFransupportLoginHistory.FransupportEnd)
            db.AddParameter("@IP", SqlDbType.NVarChar, 20, ParameterDirection.Input, objFransupportLoginHistory.IP)

            Return db.ExecuteNonQuery("PortalAdmin_Fransupport_Login_History_Add")

        End Function

    End Class

End Namespace
