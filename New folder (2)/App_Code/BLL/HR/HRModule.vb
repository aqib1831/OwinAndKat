Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data

Namespace Portal
    Public Class HRModule

        Public Sub HRModule()

        End Sub
        Public Shared Function GetSubModulesInsideNewHR(ByVal UserID As Integer, _
                                                        ByVal MainModuleID As Integer) As System.Data.DataTable
            Dim dtResult As New System.Data.DataTable()
            dtResult = Portal.DAL.HR.DBHRSubModules.GetSubModulesInsideNewHR(UserID, MainModuleID)
            Return dtResult
        End Function
    End Class
End Namespace
