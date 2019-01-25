Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data
Imports System.Data.SqlClient

Namespace Portal.BLL.Com
    Public Class com_Activities_Feedback
#Region " Private Members "
        Private _id As Integer
        Private _activityid As Integer
        Private _enteredby As Integer
        Private _enteredon As Date
        Private _promptness As Integer
        Private _courteousness As Integer
        Private _clarity As Integer
        Private _knowledgeable As Integer
        Private _rate As Integer
        Private _ratecomments As String

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

        Public Property ActivityID() As Integer
            Get
                Return _activityid
            End Get
            Set(ByVal value As Integer)
                _activityid = value
            End Set
        End Property

        Public Property EnteredBy() As Integer
            Get
                Return _enteredby
            End Get
            Set(ByVal value As Integer)
                _enteredby = value
            End Set
        End Property

        Public Property EnteredOn() As Date
            Get
                Return _enteredon
            End Get
            Set(ByVal value As Date)
                _enteredon = value
            End Set
        End Property

        Public Property Promptness() As Integer
            Get
                Return _promptness
            End Get
            Set(ByVal value As Integer)
                _promptness = value
            End Set
        End Property

        Public Property Courteousness() As Integer
            Get
                Return _courteousness
            End Get
            Set(ByVal value As Integer)
                _courteousness = value
            End Set
        End Property

        Public Property Clarity() As Integer
            Get
                Return _clarity
            End Get
            Set(ByVal value As Integer)
                _clarity = value
            End Set
        End Property

        Public Property Knowledgeable() As Integer
            Get
                Return _knowledgeable
            End Get
            Set(ByVal value As Integer)
                _knowledgeable = value
            End Set
        End Property

        Public Property Rate() As Integer
            Get
                Return _rate
            End Get
            Set(ByVal value As Integer)
                _rate = value
            End Set
        End Property

        Public Property RateComments() As String
            Get
                Return _ratecomments
            End Get
            Set(ByVal value As String)
                _ratecomments = value
            End Set
        End Property

#End Region




#Region " Public Method "

        Public Shared Function com_Activities_FeedbackGetByID(ByVal ActivityID As Integer) As DataTable
            Return Portal.DAL.Com.DBcom_Activities_Feedback.com_Activities_FeedbackGetByID(ActivityID)
        End Function

        'Public Function SupportFeedBackAdd() As Integer
        '    Dim SupportFeedBackDal As Portal.DAL.Com.DBcom_Activities_Feedback = New Portal.DAL.Com.DBcom_Activities_Feedback()
        '    Return SupportFeedBackDal.Add(Me)
        'End Function

        Public Shared Function UpdateActivityRate(ByVal ObjActivity As Portal.BLL.Com.com_Activities_Feedback) As Integer
            Dim com_ActivitiesDal As Portal.DAL.Com.DBcom_Activities_Feedback = New Portal.DAL.Com.DBcom_Activities_Feedback()
            Return com_ActivitiesDal.UpdateActivityRate(ObjActivity)
        End Function
        Public Shared Function GetActivityRateByType(ByVal Type As Integer, ByVal StartDate As Date, ByVal EndDate As Date, ByVal ClientID As Integer) As SqlDataReader
            Dim com_ActivitiesDal As Portal.DAL.Com.DBcom_Activities_Feedback = New Portal.DAL.Com.DBcom_Activities_Feedback()
            Return com_ActivitiesDal.GetActivityRateByType(Type, StartDate, EndDate, ClientID)
        End Function

        Public Shared Function GetActivityStats(ByVal StartDate As Date, ByVal EndDate As Date, ByVal ClientID As Integer) As SqlDataReader
            Dim com_ActivitiesDal As Portal.DAL.Com.DBcom_Activities_Feedback = New Portal.DAL.Com.DBcom_Activities_Feedback()
            Return com_ActivitiesDal.GetActivityStats(StartDate, EndDate, ClientID)
        End Function
#End Region

    End Class
End Namespace