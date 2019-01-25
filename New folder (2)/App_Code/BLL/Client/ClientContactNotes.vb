Imports Microsoft.VisualBasic

Namespace Portal.BLL.Client

    Public Class ClientContactNotes

        Private _Id As Integer
        Private _UserId As Integer
        Private _Status As Boolean
        Private _ChangedDate As DateTime
        Private _ChangedBy As String
        Private _Notes As String

        Public Property ID() As Integer
            Get
                Return _Id
            End Get
            Set(ByVal value As Integer)
                _Id = value
            End Set
        End Property

        Public Property UserId() As Integer
            Get
                Return _UserId
            End Get
            Set(ByVal value As Integer)
                _UserId = value
            End Set
        End Property

        Public Property Status() As Boolean
            Get
                Return _Status
            End Get
            Set(ByVal value As Boolean)
                _Status = value
            End Set
        End Property

        Public Property ChangedBy() As String
            Get
                Return _ChangedBy
            End Get
            Set(ByVal value As String)
                _ChangedBy = value
            End Set
        End Property

        Public Property ChangedDate() As DateTime
            Get
                Return _ChangedDate
            End Get
            Set(ByVal value As DateTime)
                _ChangedDate = value
            End Set
        End Property

        Public Property Notes() As String
            Get
                Return _Notes
            End Get
            Set(ByVal value As String)
                _Notes = value
            End Set
        End Property

    End Class

End Namespace
