Imports Microsoft.VisualBasic

Public Class Store
    Private _ID As Integer
    Private _StoreNumber As integer
    Private _FULLStoreName As String
    Private _CountryID As Integer
    Public Property ID() As Integer
        Get
            Return _ID
        End Get
        Set(ByVal Value As Integer)
            _ID = value
        End Set
    End Property
    Public Property StoreNumber() As Integer
        Get
            Return _StoreNumber
        End Get
        Set(ByVal Value As Integer)
            _StoreNumber = value
        End Set
    End Property

    Public Property FULLStoreName() As String
        Get
            Return _FULLStoreName
        End Get
        Set(ByVal Value As String)
            _FULLStoreName = value
        End Set
    End Property
    Public Property CountryID() As Integer
        Get
            Return _CountryID
        End Get
        Set(ByVal Value As Integer)
            _CountryID = value
        End Set
    End Property
End Class

'store.StoreNumber = dRow("StoreNumber")
'store.StoreFullName = dRow("FULLStoreName")
'store.CountryId=dRow("CountryID")