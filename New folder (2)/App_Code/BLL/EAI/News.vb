Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data
Namespace Portal.BLL
    Public Class EAI_News
#Region " Private Members "
        Private _id As Integer
        Private _newsdate As Date
        Private _headline As String
        Private _news As String
        Private _isnotice As Boolean
        Private _formanager As Boolean
        Private _deleted As Boolean
        Private _isvideo As Boolean
        Private _isweekly As Boolean

#End Region

#Region " Public Properties "

        Public Property ID() As Integer
            Get
                Return _id
            End Get
            Set(ByVal value As Integer)
                _id = value
            End Set
        End Property

        Public Property NewsDate() As Date
            Get
                Return _newsdate
            End Get
            Set(ByVal value As Date)
                _newsdate = value
            End Set
        End Property

        Public Property Headline() As String
            Get
                Return _headline
            End Get
            Set(ByVal value As String)
                _headline = value
            End Set
        End Property

        Public Property News() As String
            Get
                Return _news
            End Get
            Set(ByVal value As String)
                _news = value
            End Set
        End Property

        Public Property IsNotice() As Boolean
            Get
                Return _isnotice
            End Get
            Set(ByVal value As Boolean)
                _isnotice = value
            End Set
        End Property

        Public Property ForManager() As Boolean
            Get
                Return _formanager
            End Get
            Set(ByVal value As Boolean)
                _formanager = value
            End Set
        End Property

        Public Property Deleted() As Boolean
            Get
                Return _deleted
            End Get
            Set(ByVal value As Boolean)
                _deleted = value
            End Set
        End Property

        Public Property IsVideo() As Boolean
            Get
                Return _isvideo
            End Get
            Set(ByVal value As Boolean)
                _isvideo = value
            End Set
        End Property

        Public Property IsWeekly() As Boolean
            Get
                Return _isweekly
            End Get
            Set(ByVal value As Boolean)
                _isweekly = value
            End Set
        End Property

#End Region


#Region " Constructor "
        Public Sub New()
        End Sub

        Public Sub New( _
          ByVal ID As Integer, _
          ByVal NewsDate As Date, _
          ByVal Headline As String, _
          ByVal News As String, _
          ByVal IsNotice As Boolean, _
          ByVal ForManager As Boolean, _
          ByVal Deleted As Boolean _
         )


            Me.ID = ID
            Me.NewsDate = NewsDate
            Me.Headline = Headline
            Me.News = News
            Me.IsNotice = IsNotice
            Me.ForManager = ForManager
            Me.Deleted = Deleted


	#End Sub
#End Region

#Region " Public Method "

        Public Shared Function NewsGetAll() As List(Of EAI_News)
            Return Portal.DAL.EAI_DBNews.NewsGetAll()
        End Function

        Public Shared Function GetNewsByID(ByVal ID As Integer) As List(Of EAI_News)
            Return Portal.DAL.EAI_DBNews.GetNewsByID(ID)
        End Function
#End Region

    End Class
End Namespace