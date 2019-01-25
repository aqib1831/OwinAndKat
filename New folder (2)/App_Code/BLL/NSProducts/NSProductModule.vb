Imports Microsoft.VisualBasic
Imports System.Data.SqlClient

Namespace Portal.BLL
    Public Class NSProductModule
#Region "Properties"
        Private _ID As Integer
        Public Property ID() As Integer
            Get
                Return _ID
            End Get
            Set(ByVal value As Integer)
                _ID = value
            End Set
        End Property

        Private _Name As String
        Public Property Name() As String
            Get
                Return _Name
            End Get
            Set(ByVal value As String)
                _Name = value
            End Set
        End Property

        Private _Inactive As Boolean
        Public Property Inactive() As Boolean
            Get
                Return _Inactive
            End Get
            Set(ByVal value As Boolean)
                _Inactive = value
            End Set
        End Property

        Private _RelatedToProductID As Integer
        Public Property RelatedToProductID() As Integer
            Get
                Return _RelatedToProductID
            End Get
            Set(ByVal value As Integer)
                _RelatedToProductID = value
            End Set
        End Property

        Private _AddedBy As Integer
        Public Property AddedBy() As Integer
            Get
                Return _AddedBy
            End Get
            Set(ByVal value As Integer)
                _AddedBy = value
            End Set
        End Property

        Private _AddedOn As DateTime
        Public Property AddedOn() As DateTime
            Get
                Return _AddedOn
            End Get
            Set(ByVal value As DateTime)
                _AddedOn = value
            End Set
        End Property
#End Region
    End Class
End Namespace

