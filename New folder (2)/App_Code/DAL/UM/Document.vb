Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Namespace Portal.DAL.UM
    Public Class Document
#Region "Public Methods"
        Public Function GetAllDocumentsBySearch(ByVal Search As String, ByVal CategoryID As Integer, ByVal SortExpression As String, ByVal StartRowIndex As Integer, ByVal MaximumRows As Integer) As DataSet
            Dim dsTopics As DataSet = Nothing
            Dim db As New DBAccess
            db.AddParameter("@Search", IIf(Search = Nothing, DBNull.Value, Search))
            db.AddParameter("@CategoryID", CategoryID)
            db.AddParameter("@SortExpression", SortExpression)
            StartRowIndex = StartRowIndex + 1
            db.AddParameter("@StartRowIndex", StartRowIndex)
            db.AddParameter("@MaximumRows", MaximumRows)
            dsTopics = db.ExecuteDataSet("UM_Documents_GetBySearch")
            Return dsTopics
        End Function
        Public Function GetAllDocumentsBySearchCount(ByVal Search As String, ByVal CategoryID As Integer, ByVal SortExpression As String) As Integer
            Dim rowCount As Integer = 0
            Dim db As New DBAccess
            db.AddParameter("@Search", IIf(Search = Nothing, DBNull.Value, Search))
            db.AddParameter("@CategoryID", CategoryID)
            rowCount = db.ExecuteScalar("UM_Documents_GetBySearchCount")
            Return rowCount
        End Function
        Public Function Delete(ByVal ID As Integer) As Integer
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            Return db.ExecuteNonQuery("UM_Documents_Delete")
        End Function

        Public Function Add(ByVal document As Portal.BLL.UM.Document) As Integer
            Dim ID As Integer = 0
            Dim db As New DBAccess
            db.AddParameter("@ID", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            db.AddParameter("@CategoryID", document.CategoryID)
            db.AddParameter("@Title", document.Title)
            db.AddParameter("@Description", document.Description)
            db.AddParameter("@FileName", IIf(document.FileName = Nothing, DBNull.Value, document.FileName))
            db.AddParameter("@AddedBy", document.AddedBy)
            db.ExecuteNonQuery("UM_Documents_Add")
            ID = CInt(CType(db.Parameters("@ID"), System.Data.SqlClient.SqlParameter).Value)
            Return ID
        End Function
        Public Function Update(ByVal document As Portal.BLL.UM.Document) As Integer
            Dim ReturnValue As Integer = 0
            Dim db As New DBAccess
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            db.AddParameter("@ID", document.ID)
            db.AddParameter("@CategoryID", document.CategoryID)
            db.AddParameter("@Title", document.Title)
            db.AddParameter("@Description", document.Description)
            db.AddParameter("@LastUpdatedBy", document.LastUpdatedBy)
            db.ExecuteNonQuery("UM_Documents_Update")
            ReturnValue = CInt(CType(db.Parameters("@ReturnValue"), System.Data.SqlClient.SqlParameter).Value)
            Return ReturnValue
        End Function
        Public Shared Function DocumentGetByID(ByVal ID As Integer) As SqlDataReader
            Dim drDocument As SqlDataReader = Nothing
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            drDocument = db.ExecuteReader("UM_Documents_GetByID")
            Return drDocument
        End Function
#End Region
    End Class
End Namespace
