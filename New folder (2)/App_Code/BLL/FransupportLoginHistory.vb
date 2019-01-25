Imports Microsoft.VisualBasic


Namespace Portal.BLL


    Public Class FransupportLoginHistory

#Region " Private Members "

        Private _Id As Integer
        Private _AdminId As Integer
        Private _FransupportEnd As Portal.BLL.Enumeration.FransupportEnd
        Private _LoginDate As DateTime
        Private _IP As String

#End Region

#Region " Public Properties "


        Public Property Id() As Integer
            Get
                Return _Id
            End Get
            Set(ByVal value As Integer)
                _Id = value
            End Set
        End Property

        Public Property AdminId() As Integer
            Get
                Return _AdminId
            End Get
            Set(ByVal value As Integer)
                _AdminId = value
            End Set
        End Property

        Public Property FransupportEnd() As Portal.BLL.Enumeration.FransupportEnd
            Get
                Return _FransupportEnd
            End Get
            Set(ByVal value As Portal.BLL.Enumeration.FransupportEnd)
                _FransupportEnd = value
            End Set
        End Property

        Public Property LoginDate() As DateTime
            Get
                Return _LoginDate
            End Get
            Set(ByVal value As DateTime)
                _LoginDate = value
            End Set
        End Property

        Public Property IP() As String
            Get
                Return _IP
            End Get
            Set(ByVal value As String)
                _IP = value
            End Set
        End Property

#End Region

    End Class


End Namespace
