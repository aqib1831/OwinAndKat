Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient
Imports Microsoft.VisualBasic

Public Class Legal_Country

    Public Shared Function GetAll() As SqlDataReader
        Dim db As DBAccess = New DBAccess()
        Return db.ExecuteReader("Legal_Countries_GetAll")
    End Function

    Public Shared Function AddNew(ByVal Name As String) As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@Name", Name)
        db.AddParameter("@Value", SqlDbType.Int, 4, ParameterDirection.Output, 0)
        db.ExecuteNonQuery("Legal_Countries_Add")
        Return CInt(CType(db.Parameters("@Value"), System.Data.SqlClient.SqlParameter).Value)
    End Function

    Public Function Update(ByVal ID As Integer, ByVal Name As String) As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ID", ID)
        db.AddParameter("@Name", Name)
        db.AddParameter("@Validate", SqlDbType.Int, 4, ParameterDirection.Output, 0)
        db.ExecuteNonQuery("Legal_Countries_Update")
        Return CInt(CType(db.Parameters("@Validate"), System.Data.SqlClient.SqlParameter).Value)
    End Function

    Public Sub Delete(ByVal ID As Integer)
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ID", ID)
        db.ExecuteNonQuery("Legal_Countries_Delete")
    End Sub

End Class
