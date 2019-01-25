Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data

Namespace Portal.DAL.HR
    Public Class DBHRSubModules
        Public Shared Function GetSubModulesInsideNewHR(ByVal UserID As Integer, _
                                                        ByVal MainModuleID As Integer) As System.Data.DataTable
            Dim dtResult As New System.Data.DataTable()
            Dim db As New DBAccess()
            db.AddParameter("@userID", UserID)
            db.AddParameter("@HRMainModuleID", MainModuleID)
            dtResult = db.ExecuteDataTable("HR_GetClientUserSubModules")
            Return dtResult
        End Function
    End Class

End Namespace

