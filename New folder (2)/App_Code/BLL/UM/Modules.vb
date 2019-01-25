Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Namespace Portal.BLL.UM

    Public Class Modules

#Region "Private Fields"
        Private _ID As Integer
        Private _Title As String
        Private _AddedBy As Integer
        Private _AddedOn As DateTime
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
        Public Property Title() As String
            Get
                Return _Title
            End Get
            Set(ByVal value As String)
                _Title = value
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

#End Region
#Region "Public Methods"
        Public Shared Function GetAllModules(ByVal Type As Integer) As DataSet
            Dim dsModules As DataSet = Nothing
            Dim objModule As Portal.DAL.UM.Modules = New Portal.DAL.UM.Modules
            dsModules = objModule.GetAllModules(Type)
            Return dsModules
        End Function
#End Region

    End Class

End Namespace