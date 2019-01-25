Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Namespace Portal.DAL.UM
    Public Class Link

#Region "Public Methods"
        Public Function GetAllLinksBySearch(ByVal Search As String, ByVal CategoryID As Integer, ByVal SortExpression As String, ByVal StartRowIndex As Integer, ByVal MaximumRows As Integer) As DataSet
            Dim dsLinks As DataSet = Nothing
            Dim db As New DBAccess
            db.AddParameter("@Search", IIf(Search = Nothing, DBNull.Value, Search))
            db.AddParameter("@CategoryID", CategoryID)
            db.AddParameter("@SortExpression", SortExpression)
            StartRowIndex = StartRowIndex + 1
            db.AddParameter("@StartRowIndex", StartRowIndex)
            db.AddParameter("@MaximumRows", MaximumRows)
            dsLinks = db.ExecuteDataSet("UM_Links_GetBySearch")
            Return dsLinks
        End Function
        Public Function GetAllLinksBySearchCount(ByVal Search As String, ByVal CategoryID As Integer, ByVal SortExpression As String) As Integer
            Dim rowCount As Integer = 0
            Dim db As New DBAccess
            db.AddParameter("@Search", IIf(Search = Nothing, DBNull.Value, Search))
            db.AddParameter("@CategoryID", CategoryID)
            rowCount = db.ExecuteScalar("UM_Links_GetBySearchCount")
            Return rowCount
        End Function
        Public Function Add(ByVal link As Portal.BLL.UM.Link) As Integer
            Dim ID As Integer = 0
            Dim db As New DBAccess
            db.AddParameter("@ID", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            db.AddParameter("@CategoryID", link.CategoryID)
            db.AddParameter("@Title", link.Title)
            db.AddParameter("@Description", link.Description)
            db.AddParameter("@Link", link.Link)
            db.AddParameter("@AddedBy", link.AddedBy)
            db.ExecuteNonQuery("UM_Links_Add")
            ID = CInt(CType(db.Parameters("@ID"), System.Data.SqlClient.SqlParameter).Value)
            Return ID
        End Function
        Public Function Update(ByVal link As Portal.BLL.UM.Link) As Integer
            Dim ReturnValue As Integer = 0
            Dim db As New DBAccess
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            db.AddParameter("@ID", link.ID)
            db.AddParameter("@CategoryID", link.CategoryID)
            db.AddParameter("@Title", link.Title)
            db.AddParameter("@Description", link.Description)
            db.AddParameter("@Link", link.Link)
            db.AddParameter("@LastUpdatedBy", link.LastUpdatedBy)
            db.ExecuteNonQuery("UM_Links_Update")
            ReturnValue = CInt(CType(db.Parameters("@ReturnValue"), System.Data.SqlClient.SqlParameter).Value)
            Return ReturnValue
        End Function
        Public Function Delete(ByVal ID As Integer) As Integer
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            Return db.ExecuteNonQuery("UM_Link_Delete")
        End Function
        Public Shared Function LinkGetByID(ByVal ID As Integer) As SqlDataReader
            Dim drLink As SqlDataReader = Nothing
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            drLink = db.ExecuteReader("UM_Links_GetByID")
            Return drLink
        End Function
#End Region
    End Class
End Namespace