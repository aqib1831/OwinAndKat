Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Public Class Category
#Region " Proprties "
    Public ID As Integer
    Public Name As String
    Public CreationDate As DateTime
    Public UpdateDate As DateTime
    Public Sequence As Integer
#End Region
    Public Function Add() As Integer
        Dim intReturn As Integer = 0
        Dim objAccess As DBAccess = New DBAccess()
        objAccess.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, 0)
        objAccess.AddParameter("@Name", SqlDbType.NVarChar, 250, ParameterDirection.Input, Me.Name)
        objAccess.AddParameter("@CreationDate", SqlDbType.DateTime, 8, ParameterDirection.Input, DateTime.Now)
        objAccess.AddParameter("@UpdateDate", SqlDbType.DateTime, 8, ParameterDirection.Input, DateTime.Now)
        objAccess.AddParameter("@Sequence", SqlDbType.Int, 4, ParameterDirection.Input, Me.Sequence)
        objAccess.ExecuteNonQuery("KB_Add_Category")
        intReturn = CInt(CType(objAccess.Parameters("@ReturnValue"), System.Data.SqlClient.SqlParameter).Value)
        ID = intReturn
        objAccess.Dispose()
        Return intReturn
    End Function
    Public Function Update() As Integer
        Dim intReturn As Integer = 0
        Dim objAccess As DBAccess = New DBAccess()
        objAccess.AddParameter("@ID", SqlDbType.Int, 4, ParameterDirection.Input, Me.ID)
        objAccess.AddParameter("@Name", SqlDbType.NVarChar, 250, ParameterDirection.Input, Me.Name)
        objAccess.AddParameter("@CreationDate", SqlDbType.DateTime, 8, ParameterDirection.Input, DateTime.Now)
        objAccess.AddParameter("@UpdateDate", SqlDbType.DateTime, 8, ParameterDirection.Input, DateTime.Now)
        objAccess.AddParameter("@ReturnValue", SqlDbType.Int, 8, ParameterDirection.Output, 0)
        objAccess.AddParameter("@Sequence", SqlDbType.Int, 4, ParameterDirection.Input, Me.Sequence)
        objAccess.ExecuteNonQuery("KB_Update_Category")
        intReturn = CInt(CType(objAccess.Parameters("@ReturnValue"), System.Data.SqlClient.SqlParameter).Value)
        objAccess.Dispose()
        Return intReturn
    End Function
    Public Shared Function Delete(ByVal ID As Integer) As Integer
        Dim intReturn As Integer = 0
        Dim objAccess As DBAccess = New DBAccess()
        objAccess.AddParameter("@ID", SqlDbType.Int, 4, ParameterDirection.Input, ID)
        Return objAccess.ExecuteNonQuery("KB_Category_Delete")
        objAccess.Dispose()
    End Function
    Public Function LoadCategoryDetail(ByVal CategoryID As Integer) As Boolean
        Dim rValue As Boolean = False
        Dim db As New DBAccess
        db.AddParameter("@CategoryID", CategoryID)
        If db.ExecuteSingleRecordReader("KB_Get_CategoryByID") Then
            ID = db.GetOrdinal("ID")
            Name = Functions.ReplaceNullOrEmpty(db.GetOrdinal("Name"))
            Sequence = Functions.IfNull(db.GetOrdinal("Sequence"), 0)
            rValue = True
        Else
            rValue = False
        End If
        db.Dispose()
        Return rValue
    End Function
    Public Function GetCategories(ByVal Reccount As Nullable(Of Integer), ByVal SortExpression As String, ByVal Search As String) As SqlDataReader
        Dim db As New DBAccess
        If String.IsNullOrEmpty(Search) Then
            db.AddParameter("@Search", DBNull.Value)
        Else
            db.AddParameter("@Search", Search)
        End If
        If String.IsNullOrEmpty(SortExpression) = True Then
            SortExpression = "Sequence"
        End If
        db.AddParameter("@SortExpression", SortExpression)
        db.AddParameter("@RecCount", SqlDbType.Int, 4, ParameterDirection.Output, Reccount)
        Return CType(db.ExecuteReader("KB_Category_Search_Sorting"), SqlDataReader)
    End Function
End Class
