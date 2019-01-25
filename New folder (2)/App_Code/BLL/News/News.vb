Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data
Namespace Portal.BLL.News
    Public Class News
#Region " Private Members "
        Private _id As Integer
        Private _date As Date
        Private _headline As String
        Private _news As String
        Private _isnotice As Boolean
        Private _forcorporate As Boolean
        Private _formanager As Boolean
        Private _deleted As Boolean
        Private _isweekly As Boolean
        Private _isvideo As Boolean
        Private _isemergencymessage As Boolean
        Private _forfeeappliedfranchisee As Boolean
        Private _forallfranchisees As Boolean
        Private _weeklyletterid As Integer
        Private _addedby As Integer
        Private _editedby As Integer
        Private _cctofreshsuppliers As Boolean
        Private _newsforstoreemployee As String

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


        Public Property [Date]() As Date
            Get
                Return _date
            End Get
            Set(ByVal value As Date)
                _date = value
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

        Public Property ForCorporate() As Boolean
            Get
                Return _forcorporate
            End Get
            Set(ByVal value As Boolean)
                _forcorporate = value
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

        Public Property IsWeekly() As Boolean
            Get
                Return _isweekly
            End Get
            Set(ByVal value As Boolean)
                _isweekly = value
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

        Public Property IsEmergencyMessage() As Boolean
            Get
                Return _isemergencymessage
            End Get
            Set(ByVal value As Boolean)
                _isemergencymessage = value
            End Set
        End Property

        Public Property ForFeeAppliedFranchisee() As Boolean
            Get
                Return _forfeeappliedfranchisee
            End Get
            Set(ByVal value As Boolean)
                _forfeeappliedfranchisee = value
            End Set
        End Property

        Public Property ForAllFranchisees() As Boolean
            Get
                Return _forallfranchisees
            End Get
            Set(ByVal value As Boolean)
                _forallfranchisees = value
            End Set
        End Property

        Public Property WeeklyLetterID() As Integer
            Get
                Return _weeklyletterid
            End Get
            Set(ByVal value As Integer)
                _weeklyletterid = value
            End Set
        End Property

        Public Property AddedBy() As Integer
            Get
                Return _addedby
            End Get
            Set(ByVal value As Integer)
                _addedby = value
            End Set
        End Property

        Public Property EditedBy() As Integer
            Get
                Return _editedby
            End Get
            Set(ByVal value As Integer)
                _editedby = value
            End Set
        End Property

        Public Property CCToFreshSuppliers() As Boolean
            Get
                Return _cctofreshsuppliers
            End Get
            Set(ByVal value As Boolean)
                _cctofreshsuppliers = value
            End Set
        End Property

        Public Property NewsForStoreEmployee() As String
            Get
                Return _newsforstoreemployee
            End Get
            Set(ByVal value As String)
                _newsforstoreemployee = value
            End Set
        End Property

#End Region


#Region " Constructor "
        Public Sub New()
        End Sub

        Public Sub New( _
          ByVal ID As Integer, _
          ByVal [Date] As Date, _
          ByVal Headline As String, _
          ByVal News As String, _
          ByVal IsNotice As Boolean, _
          ByVal ForCorporate As Boolean, _
          ByVal ForManager As Boolean, _
          ByVal Deleted As Boolean, _
          ByVal IsWeekly As Boolean, _
          ByVal IsVideo As Boolean, _
          ByVal IsEmergencyMessage As Boolean, _
          ByVal ForFeeAppliedFranchisee As Boolean, _
          ByVal ForAllFranchisees As Boolean, _
          ByVal WeeklyLetterID As Integer, _
          ByVal AddedBy As Integer, _
          ByVal EditedBy As Integer, _
          ByVal CCToFreshSuppliers As Boolean, _
          ByVal NewsForStoreEmployee As String _
         )


            Me.ID = ID
            Me.Date = [Date]
            Me.Headline = Headline
            Me.News = News
            Me.IsNotice = IsNotice
            Me.ForCorporate = ForCorporate
            Me.ForManager = ForManager
            Me.Deleted = Deleted
            Me.IsWeekly = IsWeekly
            Me.IsVideo = IsVideo
            Me.IsEmergencyMessage = IsEmergencyMessage
            Me.ForFeeAppliedFranchisee = ForFeeAppliedFranchisee
            Me.ForAllFranchisees = ForAllFranchisees
            Me.WeeklyLetterID = WeeklyLetterID
            Me.AddedBy = AddedBy
            Me.EditedBy = EditedBy
            Me.CCToFreshSuppliers = CCToFreshSuppliers
            Me.NewsForStoreEmployee = NewsForStoreEmployee


        End Sub
#End Region

#Region " Public Method "

        Public Shared Function NewsGetByID(ByVal NewsID As Integer) As DataTable
            Return Portal.DAL.News.DBNews.NewsGetByID(NewsID)
        End Function
        Public Shared Function NewsGetByUserID(ByVal UserID As Integer) As DataTable
            Return Portal.DAL.News.DBNews.NewsGetByUserID(UserID)
        End Function
        Public Shared Function NewsGetByUserIDForHome() As DataTable
            Return Portal.DAL.News.DBNews.NewsGetByUserIDForHome()
        End Function
        Public Shared Function NewsAdd(ByVal [Date] As Date, ByVal Headline As String, ByVal News As String, ByVal Deleted As Boolean, ByVal IsNotice As Boolean, ByVal WeeklyLetterID As Integer, ByVal AddedBy As Integer) As Integer
            Dim NewsDal As Portal.DAL.News.DBNews = New Portal.DAL.News.DBNews()
            Return NewsDal.Add([Date], Headline, News, Deleted, IsNotice, WeeklyLetterID, AddedBy)
        End Function
#End Region

    End Class
End Namespace