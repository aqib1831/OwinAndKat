Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data
Namespace Portal.BLL
    Public Class Modules
#Region " Private Members "
        Private _id As Integer
        Private _name As String
        Private _code As String
        Private _sequence As Integer
        Private _caption As String
        Private _image As String
        Private _deleted As Boolean
        Private _url As String

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

        Public Property Name() As String
            Get
                Return _name
            End Get
            Set(ByVal value As String)
                _name = value
            End Set
        End Property

        Public Property Code() As String
            Get
                Return _code
            End Get
            Set(ByVal value As String)
                _code = value
            End Set
        End Property

        Public Property Sequence() As Integer
            Get
                Return _sequence
            End Get
            Set(ByVal value As Integer)
                _sequence = value
            End Set
        End Property

        Public Property Caption() As String
            Get
                Return _caption
            End Get
            Set(ByVal value As String)
                _caption = value
            End Set
        End Property

        Public Property Image() As String
            Get
                Return _image
            End Get
            Set(ByVal value As String)
                _image = value
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

        Public Property URL() As String
            Get
                Return _url
            End Get
            Set(ByVal value As String)
                _url = value
            End Set
        End Property

#End Region
#Region " Constructor "
        Public Sub New()
        End Sub



        Public Sub New( _
          ByVal ID As Integer, _
          ByVal Name As String, _
          ByVal Code As String, _
          ByVal Sequence As Integer, _
          ByVal Caption As String, _
          ByVal Image As String, _
          ByVal Deleted As Boolean, _
          ByVal URL As String _
         )


            Me.ID = ID
            Me.Name = Name
            Me.Code = Code
            Me.Sequence = Sequence
            Me.Caption = Caption
            Me.Image = Image
            Me.Deleted = Deleted
            Me.URL = URL


	#End Sub
#End Region
#Region " Public Method "
        Public Shared Function ModulesGetAll() As List(Of Modules)
            Return Portal.DAL.DBModules.ModulesGetAll()
        End Function
        Public Shared Function ModulesGetByIDs(ByVal IDs As String) As List(Of Modules)
            Return Portal.DAL.DBModules.ModulesGetByIDs(IDs)
        End Function
        Public Shared Function ModulesGetByUserID(ByVal UserID As Integer) As List(Of Modules)
            Return Portal.DAL.DBModules.ModulesGetByUserID(UserID)
        End Function
        Public Shared Function SubModulesGetByUserID(ByVal UserID As Integer) As String
            Return Portal.DAL.DBModules.SubModulesGetByUserID(UserID)
        End Function
        'Public Shared Function ModulesAdd(ByVal ID As Integer, ByVal Name As String, ByVal Code As String, ByVal Sequence As Integer, ByVal Caption As String, ByVal Image As String, ByVal Deleted As Boolean, ByVal URL As String) As Integer
        '    Dim ModulesBll As Portal.BLL.Modules = New Portal.BLL.Modules(ID, Name, Code, Sequence, Caption, Image, Deleted, URL)
        '    Dim ModulesDal As Portal.DAL.DBModules = New Portal.DAL.DBModules()
        '    Return ModulesDal.Add(ModulesBll)
        'End Function
#End Region

    End Class
End Namespace