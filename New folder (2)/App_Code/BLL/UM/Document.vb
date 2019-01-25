Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Namespace Portal.BLL.UM
    Public Class Document

        Protected strAlbumPath As String

#Region "Private Fields"
        Private _ID As Integer
        Private _CategoryID As Integer
        Private _Title As String
        Private _Description As String
        Private _FileName As String
        Private _AddedBy As Integer
        Private _AddedOn As DateTime
        Private _LastUpdatedBy As Integer
        Private _LastUpdatedOn As DateTime
        Private _FileUpload As FileUpload
        Private _DirectoryName As String
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
        Public Property CategoryID() As Integer
            Get
                Return _CategoryID
            End Get
            Set(ByVal value As Integer)
                _CategoryID = value
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
        Public Property Description() As String
            Get
                Return _Description
            End Get
            Set(ByVal value As String)
                _Description = value
            End Set
        End Property
        Public Property FileName() As String
            Get
                Return _FileName
            End Get
            Set(ByVal value As String)
                _FileName = value
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
        Public Property LastUpdatedBy() As Integer
            Get
                Return _LastUpdatedBy
            End Get
            Set(ByVal value As Integer)
                _LastUpdatedBy = value
            End Set
        End Property
        Public Property LastUpdatedOn() As DateTime
            Get
                Return _LastUpdatedOn
            End Get
            Set(ByVal value As DateTime)
                _LastUpdatedOn = value
            End Set
        End Property
        Public Property FileUpload() As FileUpload
            Get
                Return _FileUpload
            End Get
            Set(ByVal value As FileUpload)
                _FileUpload = value
            End Set
        End Property
        Public Property DirectoryName() As String
            Get
                Return _DirectoryName
            End Get
            Set(ByVal value As String)
                _DirectoryName = value
            End Set
        End Property
#End Region
#Region "Public Methods"
        Public Function GetAllDocumentsBySearch(ByVal Search As String, ByVal CategoryID As Integer, ByVal SortExpression As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As DataSet
            Dim ObjDALDocument As New Portal.DAL.UM.Document
            Dim dsDocument As DataSet = Nothing
            dsDocument = ObjDALDocument.GetAllDocumentsBySearch(Search, CategoryID, SortExpression, startRowIndex, maximumRows)
            Return dsDocument
        End Function
        Public Function GetAllDocumentsBySearchCount(ByVal Search As String, ByVal CategoryID As Integer, ByVal SortExpression As String) As Integer
            Dim ObjDALDocument As New Portal.DAL.UM.Document
            Dim rowCount As Integer = 0
            rowCount = ObjDALDocument.GetAllDocumentsBySearchCount(Search, CategoryID, SortExpression)
            Return rowCount
        End Function
        Public Function Delete(ByVal ID As Integer) As Integer
            Dim ObjDALDocument As New Portal.DAL.UM.Document
            ObjDALDocument.Delete(ID)
        End Function
        Public Function Add() As Integer
            Dim ID As Integer = 0
            Dim ObjDALDocument As New Portal.DAL.UM.Document
            If Me.FileUpload.FileName <> Nothing Then
                SaveDocument()
            End If
            ID = ObjDALDocument.Add(Me)
            Return ID
        End Function
        Public Function Update() As Integer
            Dim ReturnValue As Integer = 0
            Dim ObjDALDocument As New Portal.DAL.UM.Document
            ReturnValue = ObjDALDocument.Update(Me)
            Return ReturnValue
        End Function

        Public Shared Function DocumentGetByID(ByVal ID As Integer) As SqlDataReader
            Dim drDocument As SqlDataReader = Nothing
            drDocument = Portal.DAL.UM.Document.DocumentGetByID(ID)
            Return drDocument
        End Function
        Public Sub SaveDocument()
            strAlbumPath = ConfigurationManager.AppSettings("PortalComAttachmentPath") + DirectoryName
            If My.Computer.FileSystem.DirectoryExists(HttpContext.Current.Server.MapPath(strAlbumPath)) = False Then
                My.Computer.FileSystem.CreateDirectory(HttpContext.Current.Server.MapPath(strAlbumPath))
            End If
            If Me.FileUpload.HasFile Then
                Dim fileName As String = Me.FileUpload.FileName
                Me.FileUpload.SaveAs(HttpContext.Current.Server.MapPath(ConfigurationManager.AppSettings("PortalComAttachmentPath")) & Me.FileName)
            End If
        End Sub
#End Region
    End Class
End Namespace
