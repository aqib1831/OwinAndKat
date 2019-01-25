Imports Microsoft.VisualBasic
Imports System.Data.SqlClient

Namespace Portal.DAL
    Public Class DBAreaDeveloper

        Public Shared Function GetAllByClientID(ByVal ClientID As Integer) As SqlDataReader
            Dim objDb As New DBAccess
            objDb.AddParameter("@ClientId", ClientID)
            Return objDb.ExecuteReader("AreaDeveloper_GetAllByClientID")
        End Function

    End Class
End Namespace


