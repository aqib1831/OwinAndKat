Imports Microsoft.VisualBasic
Namespace Portal.BLL
    Public Class ActivitySurvey
#Region "Private Members"
        Private _Activityid As Integer
        Private _EnteredByFranContactID As Integer
        Private _EnteredByClientContactID As Integer
        Private _Enteredon As Date
        Private _ActivityRate As Integer
        Private _SurveyComments As String
#End Region
#Region "Constructors"
        Public Sub New()
        End Sub
#End Region
#Region " Public Properties "
        Public Property ActivityID() As Integer
            Get
                Return _Activityid
            End Get
            Set(ByVal value As Integer)
                _Activityid = value
            End Set
        End Property

        Public Property EnteredByFranContactID() As Integer
            Get
                Return _EnteredByFranContactID
            End Get
            Set(ByVal value As Integer)
                _EnteredByFranContactID = value
            End Set
        End Property
        Public Property EnteredByClientContactID() As Integer
            Get
                Return _EnteredByClientContactID
            End Get
            Set(ByVal value As Integer)
                _EnteredByClientContactID = value
            End Set
        End Property
        Public Property EnteredOn() As Date
            Get
                Return _Enteredon
            End Get
            Set(ByVal value As Date)
                _Enteredon = value
            End Set
        End Property
        Public Property ActivityRate() As Integer
            Get
                Return _ActivityRate
            End Get
            Set(ByVal value As Integer)
                _ActivityRate = value
            End Set
        End Property

        Public Property SurveyComments() As String
            Get
                Return _SurveyComments
            End Get
            Set(ByVal value As String)
                _SurveyComments = value
            End Set
        End Property
#End Region
#Region "Public Methods"
        Public Function Add()
            Return Portal.DAL.ActivitySurvey.Add(Me.ActivityID, Me.ActivityRate, Me.EnteredByFranContactID, Me.EnteredByClientContactID, Me.SurveyComments)
        End Function
#End Region
    End Class
End Namespace

