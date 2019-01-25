Imports Microsoft.VisualBasic
Imports Portal.BLL
Imports System.Data
Imports System.Data.SqlClient

Namespace Portal.BLL
    Public Class ActivityNotes

#Region "Private Variables"
        Private _NotesID As Integer
        Private _ActivityID As Integer
        Private _Notes As String
        Private _NotesType As Enumeration.ActivityNotesType
        Private _AdminID As Integer
        Private _FranchiseContactID As Integer
        Private _ClientContactID As Integer
        Private _PlacedBy As Integer
        Private _NotesDate As DateTime
#End Region

#Region "Public Properties"
        Public Property NotesID() As Integer
            Get
                Return _NotesID
            End Get
            Set(ByVal value As Integer)
                _NotesID = value
            End Set
        End Property
        Public Property ActivityID() As Integer
            Get
                Return _ActivityID
            End Get
            Set(ByVal value As Integer)
                _ActivityID = value
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
        Public Property NotesType() As Enumeration.ActivityNotesType
            Get
                Return _NotesType
            End Get
            Set(ByVal value As Enumeration.ActivityNotesType)
                _NotesType = value
            End Set
        End Property
        Public Property FranchiseContactID() As Integer
            Get
                Return _FranchiseContactID
            End Get
            Set(ByVal value As Integer)
                _FranchiseContactID = value
            End Set
        End Property
        Public Property AdminID() As Integer
            Get
                Return _AdminID
            End Get
            Set(ByVal value As Integer)
                _AdminID = value
            End Set
        End Property
        Public Property ClientContactID() As Integer
            Get
                Return _ClientContactID
            End Get
            Set(ByVal value As Integer)
                _ClientContactID = value
            End Set
        End Property
        Public Property PlacedBy() As Integer
            Get
                Return _PlacedBy
            End Get
            Set(ByVal value As Integer)
                _PlacedBy = value
            End Set
        End Property
        Public Property NotesDate() As DateTime
            Get
                Return _NotesDate
            End Get
            Set(ByVal value As DateTime)
                _NotesDate = value
            End Set
        End Property
#End Region

#Region "Constructor"
        Public Sub New()
        End Sub
#End Region

#Region "Public Functions"
        Public Function AddNotes() As Integer
            Dim objActivityNotes As Portal.DAL.ActivityNotes = New Portal.DAL.ActivityNotes()
            Return objActivityNotes.AddNotes(Me)
        End Function
        Public Function GetNotesByActivityID(ByVal ActivityId As Integer) As SqlDataReader
            Dim objActivityNotes As Portal.DAL.ActivityNotes = New Portal.DAL.ActivityNotes()
            Return objActivityNotes.GetNotesByActivityID(ActivityId)
        End Function
        Public Function GetPublicNotesByActivityID(ByVal ActivityId As Integer) As SqlDataReader
            Dim objActivityNotes As Portal.DAL.ActivityNotes = New Portal.DAL.ActivityNotes()
            Return objActivityNotes.GetPublicNotesByActivityID(ActivityId)
        End Function
#End Region

    End Class
End Namespace

