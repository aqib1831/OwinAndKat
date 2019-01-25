Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient

Namespace Portal.BLL
    Public Class ActivityAttachements

#Region "Private Variables"
        Private _ActivityID As Integer
        Private _NotesID As Integer
        Private _FileName As String
        Private _DirectoryName As String
        Private _FilePath As String
#End Region

#Region "Public Properties"
        Public Property ActivityID() As Integer
            Get
                Return _ActivityID
            End Get
            Set(ByVal value As Integer)
                _ActivityID = value
            End Set
        End Property
        Public Property NotesID() As Integer
            Get
                Return _NotesID
            End Get
            Set(ByVal value As Integer)
                _NotesID = value
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
        Public Property DirectoryName() As String
            Get
                Return _DirectoryName
            End Get
            Set(ByVal value As String)
                _DirectoryName = value
            End Set
        End Property
        Public Property FilePath() As String
            Get
                Return _FilePath
            End Get
            Set(ByVal value As String)
                _FilePath = value
            End Set
        End Property
#End Region

#Region "Public Functions"
        Public Function SaveAttachments(ByVal DirectoryName As String, ByVal Attachment As FileUpload) As Integer
            Dim objActivityAttachement As Portal.DAL.ActivityAttachements = New Portal.DAL.ActivityAttachements()
            Return objActivityAttachement.SaveAttachments(DirectoryName, Attachment, Me)
        End Function
        Public Function GetAttachmentPath(ByVal DirectoryName As String) As String
            Dim objActivityAttachement As Portal.DAL.ActivityAttachements = New Portal.DAL.ActivityAttachements()
            Return objActivityAttachement.GetAttachmentPath(DirectoryName)
        End Function
        Public Function AddAttachment(ByVal objActivityAttachment As Portal.BLL.ActivityAttachements) As Integer
            Dim objAttachement As Portal.DAL.ActivityAttachements = New Portal.DAL.ActivityAttachements()
            Return objAttachement.AddAttachments(objActivityAttachment)
        End Function
#End Region

    End Class

End Namespace