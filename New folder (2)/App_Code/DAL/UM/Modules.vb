Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Namespace Portal.DAL.UM

    Public Class Modules

        Public Function GetAllModules(ByVal Type As Integer) As DataSet
            Dim dsModules As DataSet = Nothing
            Dim db As New DBAccess
            db.AddParameter("@Type", Type)
            dsModules = db.ExecuteDataSet("UM_Modules_GetAllForList")
            Return dsModules
        End Function

    End Class
End Namespace
