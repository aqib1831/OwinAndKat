Imports Microsoft.VisualBasic
Imports Portal.DAL
Imports System.Data.SqlClient

Namespace Portal.BLL
    Public Class AreaDeveloper

#Region "Methods"
        Public Function GetAllByClientId(ByVal ClientID As Integer) As SqlDataReader
            Return DBAreaDeveloper.GetAllByClientID(ClientID)
        End Function
#End Region

    End Class
End Namespace


