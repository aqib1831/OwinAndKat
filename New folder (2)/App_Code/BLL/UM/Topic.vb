Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Namespace Portal.BLL.UM

    Public Class Topic
#Region "Private Fields"
        Private _ID As Integer
        Private _CategoryID As Integer
        Private _Type As Integer
        Private _Title As String
        Private _Description As String
        Private _AddedBy As Integer
        Private _AddedOn As DateTime
        Private _LastUpdatedBy As Integer
        Private _LastUpdatedOn As DateTime
        Private _ManualType As Integer
#End Region
#Region "Public Properties"
        Public Property ID() As Integer
            Get
                Return _ID
            End Get
            Set(ByVal value As Integer)
                _ID = value
            End Set
        End Property
        Public Property CategoryID() As Integer
            Get
                Return _CategoryID
            End Get
            Set(ByVal value As Integer)
                _CategoryID = value
            End Set
        End Property
        Public Property Type() As Integer
            Get
                Return _Type
            End Get
            Set(ByVal value As Integer)
                _Type = value
            End Set
        End Property
        Public Property Title() As String
            Get
                Return _Title
            End Get
            Set(ByVal value As String)
                _Title = value
            End Set
        End Property
        Public Property Description() As String
            Get
                Return _Description
            End Get
            Set(ByVal value As String)
                _Description = value
            End Set
        End Property
        Public Property AddedBy() As Integer
            Get
                Return _AddedBy
            End Get
            Set(ByVal value As Integer)
                _AddedBy = value
            End Set
        End Property
        Public Property AddedOn() As DateTime
            Get
                Return _AddedOn
            End Get
            Set(ByVal value As DateTime)
                _AddedOn = value
            End Set
        End Property
        Public Property LastUpdatedBy() As Integer
            Get
                Return _LastUpdatedBy
            End Get
            Set(ByVal value As Integer)
                _LastUpdatedBy = value
            End Set
        End Property
        Public Property LastUpdatedOn() As DateTime
            Get
                Return _LastUpdatedOn
            End Get
            Set(ByVal value As DateTime)
                _LastUpdatedOn = value
            End Set
        End Property
        Public Property ManualType() As Integer
            Get
                Return _ManualType
            End Get
            Set(ByVal value As Integer)
                _ManualType = value
            End Set
        End Property
#End Region

#Region "Public Methods"
        Public Function GetAllTopicsBySearch(ByVal Search As String, ByVal TypeID As Integer, ByVal UMType As Integer, ByVal CategoryID As Integer, ByVal SortExpression As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As DataSet
            Dim ObjDALTopic As New Portal.DAL.UM.Topic
            Dim dsTopics As DataSet = Nothing
            dsTopics = ObjDALTopic.GetAllTopicsBySearch(Search, TypeID, UMType, CategoryID, SortExpression, startRowIndex, maximumRows)
            Return dsTopics
        End Function
        Public Function GetAllTopicsBySearchCount(ByVal Search As String, ByVal TypeID As Integer, ByVal UMType As Integer, ByVal CategoryID As Integer, ByVal SortExpression As String) As Integer
            Dim ObjDALTopic As New Portal.DAL.UM.Topic
            Dim rowCount As Integer = 0
            rowCount = ObjDALTopic.GetAllTopicsBySearchCount(Search, TypeID, UMType, CategoryID, SortExpression)
            Return rowCount
        End Function
        Public Function GetRecentlyUpdatedTopics(ByVal Search As String, ByVal SortExpression As String) As DataSet
            Dim dsTopics As DataSet = Nothing
            Dim objTopics As Portal.DAL.UM.Topic = New Portal.DAL.UM.Topic
            dsTopics = objTopics.GetRecentlyUpdatedTopics(Search, SortExpression)
            Return dsTopics
        End Function

        Public Function Add() As Integer
            Dim ID As Integer = 0
            Dim ObjDALTopic As New Portal.DAL.UM.Topic
            ID = ObjDALTopic.Add(Me)
            Return ID
        End Function
        Public Function Update() As Integer
            Dim ReturnValue As Integer = 0
            Dim ObjDALTopic As New Portal.DAL.UM.Topic
            ReturnValue = ObjDALTopic.Update(Me)
            Return ReturnValue
        End Function
        Public Function Delete(ByVal ID As Integer) As Integer
            Dim ObjDALTopic As New Portal.DAL.UM.Topic
            ObjDALTopic.Delete(ID)
        End Function

        Public Shared Function TopicGetByID(ByVal ID As Integer) As SqlDataReader
            Dim drTopic As SqlDataReader = Nothing
            drTopic = Portal.DAL.UM.Topic.TopicGetByID(ID)
            Return drTopic
        End Function
        Public Shared Function GetRecentlyUpdatedTopicsForClientEnd(ByVal CategoryID As Integer, ByVal SortExpression As String) As SqlDataReader
            Return Portal.DAL.UM.Topic.GetRecentlyUpdatedTopicsForClientEnd(CategoryID, SortExpression)
        End Function

        Public Shared Function LeftPanelSearchForClientEnd(ByVal CategoryID As Integer, ByVal Search As String) As SqlDataReader
            Return Portal.DAL.UM.Topic.LeftPanelSearchForClientEnd(CategoryID, Search)
        End Function
        Public Shared Function GetTopicsByCategoryID(ByVal CategoryID As Integer) As SqlDataReader
            Return Portal.DAL.UM.Topic.GetTopicsByCategoryID(CategoryID)
        End Function
        Public Shared Function GetTopicIDBynXstepSelectionID(ByVal SelectionID As Integer) As Integer
            Return Portal.DAL.UM.Topic.GetTopicIDBynXstepSelectionID(SelectionID)
        End Function

        Public Shared Function GetTopicIDByClientIDANDSelectionID(ByVal SelectionID As Integer, ByVal ClientID As Integer) As Integer
            Return Portal.DAL.UM.Topic.GetTopicIDByClientIDANDSelectionID(SelectionID, ClientID)
        End Function
        Public Shared Function GetTopicsByGlobalSearch(ByVal Search As String, ByVal Type As String) As SqlDataReader
            Return Portal.DAL.UM.Topic.GetTopicsByGlobalSearch(Search, Convert.ToInt32(Type))
        End Function
#End Region
    End Class
End Namespace