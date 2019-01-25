Imports Microsoft.VisualBasic
Imports System.Data.SqlClient

Namespace Portal.BLL.Legal
    Public Class AdminAccess
        Public Shared Function GetAllLegalAdmins(ByVal search As String) As SqlDataReader
            Dim objDbAccess As New DBAccess
            objDbAccess.AddParameter("@Search", IIf(String.IsNullOrEmpty(search), DBNull.Value, search))
            Return objDbAccess.ExecuteReader("Legal_Admins_GetAll")
        End Function

        Public Function AddAdmins(ByVal adminIds As String) As Integer
            Dim objDbAccess As New DBAccess
            objDbAccess.AddParameter("@AdminIds", IIf(String.IsNullOrEmpty(adminIds) = False, adminIds, DBNull.Value))
            Return objDbAccess.ExecuteNonQuery("Legal_Admins_Add")
        End Function
    End Class
End Namespace