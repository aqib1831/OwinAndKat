Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient

Namespace Portal.DAL.UM

    Public Class Topic
#Region "Public Methods"
        Public Function GetAllTopicsBySearch(ByVal Search As String, ByVal TypeID As Integer, ByVal UMType As Integer, ByVal CategoryID As Integer, ByVal SortExpression As String, ByVal StartRowIndex As Integer, ByVal MaximumRows As Integer) As DataSet
            Dim dsTopics As DataSet = Nothing
            Dim db As New DBAccess
            db.AddParameter("@Search", IIf(Search = Nothing, DBNull.Value, Search))
            db.AddParameter("@TypeID", TypeID)
            db.AddParameter("@CategoryID", CategoryID)
            db.AddParameter("@UMType", UMType)
            db.AddParameter("@SortExpression", SortExpression)
            StartRowIndex = StartRowIndex + 1
            db.AddParameter("@StartRowIndex", StartRowIndex)
            db.AddParameter("@MaximumRows", MaximumRows)
            dsTopics = db.ExecuteDataSet("UM_Topics_GetBySearch")
            Return dsTopics
        End Function
        Public Function GetAllTopicsBySearchCount(ByVal Search As String, ByVal TypeID As Integer, ByVal UMType As Integer, ByVal CategoryID As Integer, ByVal SortExpression As String) As Integer
            Dim rowCount As Integer = 0
            Dim db As New DBAccess
            db.AddParameter("@Search", IIf(Search = Nothing, DBNull.Value, Search))
            db.AddParameter("@TypeID", TypeID)
            db.AddParameter("@CategoryID", CategoryID)
            db.AddParameter("@UMType", UMType)
            rowCount = db.ExecuteScalar("UM_Topics_GetBySearchCount")
            Return rowCount
        End Function
        Public Function GetRecentlyUpdatedTopics(ByVal Search As String, ByVal SortExpression As String) As DataSet
            Dim dsTopics As DataSet = Nothing
            Dim db As New DBAccess
            db.AddParameter("@Search", IIf(Search = Nothing, DBNull.Value, Search))
            db.AddParameter("@SortExpression", SortExpression)
            dsTopics = db.ExecuteDataSet("UM_Topics_RecentlyUpdated")
            Return dsTopics
        End Function
        Public Function Add(ByVal topic As Portal.BLL.UM.Topic) As Integer
            Dim ID As Integer = 0
            Dim db As New DBAccess
            db.AddParameter("@ID", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            db.AddParameter("@CategoryID", topic.CategoryID)
            db.AddParameter("@Title", topic.Title)
            db.AddParameter("@Description", topic.Description)
            db.AddParameter("@Type", topic.Type)
            db.AddParameter("@AddedBy", topic.AddedBy)
            db.AddParameter("@ManualTypeID", topic.ManualType)
            db.ExecuteNonQuery("UM_Topics_Add")
            ID = CInt(CType(db.Parameters("@ID"), System.Data.SqlClient.SqlParameter).Value)
            Return ID
        End Function
        Public Function Update(ByVal topic As Portal.BLL.UM.Topic) As Integer
            Dim ReturnValue As Integer = 0
            Dim db As New DBAccess
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            db.AddParameter("@ID", topic.ID)
            db.AddParameter("@CategoryID", topic.CategoryID)
            db.AddParameter("@Title", topic.Title)
            db.AddParameter("@Description", topic.Description)
            db.AddParameter("@Type", topic.Type)
            db.AddParameter("@LastUpdatedBy", topic.LastUpdatedBy)
            db.AddParameter("@ManualTypeID", topic.ManualType)
            db.ExecuteNonQuery("UM_Topics_Update")
            ReturnValue = CInt(CType(db.Parameters("@ReturnValue"), System.Data.SqlClient.SqlParameter).Value)
            Return ReturnValue
        End Function
        Public Function Delete(ByVal ID As Integer) As Integer
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            Return db.ExecuteNonQuery("UM_Topics_Delete")
        End Function
        Public Shared Function TopicGetByID(ByVal ID As Integer) As SqlDataReader
            Dim drTopic As SqlDataReader = Nothing
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            drTopic = db.ExecuteReader("UM_Topics_GetByID")
            Return drTopic
        End Function

        Public Shared Function GetRecentlyUpdatedTopicsForClientEnd(ByVal CategoryID As Integer, ByVal SortExpression As String) As SqlDataReader
            Dim drTopic As SqlDataReader = Nothing
            Dim db As New DBAccess
            db.AddParameter("@CategoryID", CategoryID)
            db.AddParameter("@SortExpression", SortExpression)
            drTopic = db.ExecuteReader("UM_Topics_RecentlyUpdatedForClientEND")
            Return drTopic
        End Function

        Public Shared Function LeftPanelSearchForClientEnd(ByVal CategoryID As Integer, ByVal Search As String) As SqlDataReader
            Dim drTopic As SqlDataReader = Nothing
            Dim db As New DBAccess
            db.AddParameter("@CategoryID", CategoryID)
            db.AddParameter("@Search", Search)
            drTopic = db.ExecuteReader("UM_Topics_GetBySearchAndCategoryID")
            Return drTopic
        End Function

        Public Shared Function GetTopicsByCategoryID(ByVal CategoryID As Integer) As SqlDataReader
            Dim drCategories As SqlDataReader = Nothing
            Dim db As New DBAccess
            db.AddParameter("@CategoryID", CategoryID)
            drCategories = db.ExecuteReader("UM_Topics_GetByCategoryID")
            Return drCategories
        End Function
        Public Shared Function GetTopicIDBynXstepSelectionID(ByVal SelectionID As Integer) As Integer
            Dim dr As SqlDataReader = Nothing
            Dim db As New DBAccess
            Dim TopicID As Integer = 0
            db.AddParameter("@SelectionID", SelectionID)
            dr = db.ExecuteReader("UM_GetTopicBySelectionID")
            If dr.Read() Then
                TopicID = dr.Item("TopicID")
            End If
            dr.Close()
            Return TopicID
        End Function
        Public Shared Function GetTopicIDByClientIDANDSelectionID(ByVal SelectionID As Integer, ByVal ClientID As Integer) As Integer
            Dim dr As SqlDataReader = Nothing
            Dim db As New DBAccess
            Dim TopicID As Integer = 0
            db.AddParameter("@SelectionID", SelectionID)
            db.AddParameter("@ClientID", ClientID)
            dr = db.ExecuteReader("UM_GetTopicBySelectionIDANDClientID")
            If dr.Read() Then
                TopicID = dr.Item("TopicID")
            End If
            dr.Close()
            Return TopicID
        End Function
        Public Shared Function GetTopicsByGlobalSearch(ByVal Search As String, ByVal Type As Integer) As SqlDataReader
            Dim drTopic As SqlDataReader = Nothing
            Dim db As New DBAccess
            db.AddParameter("@SearchQuery", Search)
            db.AddParameter("@Type", Type)
            drTopic = db.ExecuteReader("UM_Topics_GetTopicsByGlobalSearch")
            Return drTopic
        End Function
#End Region
    End Class
End Namespace