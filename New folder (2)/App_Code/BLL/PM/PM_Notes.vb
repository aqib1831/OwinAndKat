Imports System.Data
Imports System.Data.SqlClient
Imports System.IO

Namespace Portal.BLL.PM
    Public Class PM_Notes

#Region " Private Members "
        Private _Id As Integer
        Private _notesId As Integer
        Private _filePath As String
        Private _fileSize As Decimal
        Private _fileName As String
        Private _notes As String
        Private _adminId As Integer
        Private _WaitingFor As Integer
        Private _ticket_feature_ID As Integer
        Private _name As String
        Private _Submittedby As Integer
        Private _dateEntered As DateTime
        Private _isadmin As Boolean
        Private _timespent As String
        Private _clientcontactid As Integer
        Private _type As Boolean
        Private _isFeedbackRequired As Boolean = False
        Private _AttachmentType As Integer
#End Region

#Region " Public Properties "


        Public Property FileSize() As Decimal
            Get
                Return _fileSize
            End Get
            Set(ByVal value As Decimal)
                _fileSize = value
            End Set
        End Property


        Public Property Notes() As String
            Get
                Return _notes
            End Get
            Set(ByVal value As String)
                _notes = value
            End Set
        End Property


        Public Property FilePath() As String
            Get
                Return _filePath
            End Get
            Set(ByVal value As String)
                _filePath = value
            End Set
        End Property

        Public Property FileName() As String
            Get
                Return _fileName
            End Get
            Set(ByVal value As String)
                _fileName = value
            End Set
        End Property

        Public Property IdeaID() As Integer
            Get
                Return _Id
            End Get
            Set(ByVal value As Integer)
                _Id = value
            End Set
        End Property

        Public Property WaitingFor() As Integer
            Get
                Return _WaitingFor
            End Get
            Set(ByVal value As Integer)
                _WaitingFor = value
            End Set
        End Property

        Public Property Ticket_Feature_ID() As Integer
            Get
                Return _ticket_feature_ID
            End Get
            Set(ByVal value As Integer)
                _ticket_feature_ID = value
            End Set
        End Property

        Public Property AdminID() As Integer
            Get
                Return _adminId
            End Get
            Set(ByVal value As Integer)
                _adminId = value
            End Set
        End Property


        Public Property NotesID() As Integer
            Get
                Return _notesId
            End Get
            Set(ByVal value As Integer)
                _notesId = value
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

        Public Property SubmittedBy() As Integer
            Get
                Return _Submittedby
            End Get
            Set(ByVal value As Integer)
                _Submittedby = value
            End Set
        End Property

        Public Property IsByAdmin() As Boolean
            Get
                Return _isadmin
            End Get
            Set(ByVal value As Boolean)
                _isadmin = value
            End Set
        End Property


        Public Property DateEntered() As DateTime
            Get
                Return _dateEntered
            End Get
            Set(ByVal value As DateTime)
                _dateEntered = value
            End Set
        End Property

        Public Property TimeSpent() As String
            Get
                Return _timespent
            End Get
            Set(ByVal value As String)
                _timespent = value
            End Set
        End Property

        Public Property ClientContactID() As Integer
            Get
                Return _clientcontactid
            End Get
            Set(ByVal value As Integer)
                _clientcontactid = value
            End Set
        End Property


        Public Property Type() As Boolean
            Get
                Return _type
            End Get
            Set(ByVal value As Boolean)
                _type = value
            End Set
        End Property

        Public Property IsFeedbackRequired() As Boolean
            Get
                Return _isFeedbackRequired
            End Get
            Set(ByVal value As Boolean)
                _isFeedbackRequired = value
            End Set
        End Property

        Public Property AttachmentType As Integer
            Get
                Return _AttachmentType
            End Get
            Set(value As Integer)
                _AttachmentType = value
            End Set
        End Property

#End Region


        'Public Sub GetIdeaDetailByID(ByVal ID As Integer)
        '    Dim db As New DBAccess
        '    db.AddParameter("@ID", ID)
        '    If db.ExecuteSingleRecordReader("Research_GetIdeaDetailByID") Then
        '        IdeaID = ID
        '        Title = Functions.IfNull(db.GetOrdinal("Title"), "")
        '        Description = Functions.IfNull(db.GetOrdinal("Description"), "")
        '        Name = Functions.IfNull(db.GetOrdinal("ContactName"), "")
        '        SubmittedOn = DateTime.Parse(db.GetOrdinal("SubmissionDate"))
        '        StartDate = DateTime.Parse(Functions.IfNull(db.GetOrdinal("StartDate"), DateTime.Now))
        '        DueDate = DateTime.Parse(Functions.IfNull(db.GetOrdinal("DueDate"), DateTime.Now))
        '        AdminID = Functions.IfNull(db.GetOrdinal("AdminID"), 0)
        '        Completed = Functions.IfNull(db.GetOrdinal("Completed"), 0)
        '        FranchiseContactID = db.GetOrdinal("FranchiseContactID")
        '        FranchiseID = Functions.IfNull(db.GetOrdinal("IdeaBYAdmin"), 0)
        '        ConceptID = Functions.IfNull(db.GetOrdinal("ConceptID"), 0)
        '        TypeID = Functions.IfNull(db.GetOrdinal("TypeID"), 0)
        '        StatusID = Functions.IfNull(db.GetOrdinal("StatusID"), 0)
        '        ApprovalID = Functions.IfNull(db.GetOrdinal("ApprovedStatusID"), 0)
        '        AssignTo = Functions.IfNull(db.GetOrdinal("AssignTo"), 0)
        '        RemainingDays = Functions.IfNull(db.GetOrdinal("RemainingDays"), 0)
        '        Reason = Functions.IfNull(db.GetOrdinal("RejectionReason"), "")
        '    End If
        '    db.Dispose()
        'End Sub



        Public Function Notes_Add() As Integer

            Dim intReturn As Integer = 0
            Dim objAccess As DBAccess = New DBAccess()
            objAccess.AddParameter("@Ticket_Feature_ID", SqlDbType.Int, 4, ParameterDirection.Input, Me._ticket_feature_ID)
            objAccess.AddParameter("@UserID", IIf(Me._Submittedby = 0, DBNull.Value, Me._Submittedby))
            objAccess.AddParameter("@ClientContactID", IIf(Me.ClientContactID = 0, DBNull.Value, Me.ClientContactID))
            objAccess.AddParameter("@DateEntered", SqlDbType.DateTime, 8, ParameterDirection.Input, Me._dateEntered)
            objAccess.AddParameter("@Notes", Me._notes)
            objAccess.AddParameter("@IsAdmin", SqlDbType.Bit, 1, ParameterDirection.Input, Me._isadmin)
            objAccess.AddParameter("@TimeSpent", SqlDbType.VarChar, 8, ParameterDirection.Input, Me._timespent)
            objAccess.AddParameter("@Type", Me.Type)
            objAccess.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, intReturn)
            objAccess.AddParameter("@IsClientFeedback", SqlDbType.Bit, 1, ParameterDirection.Input, Me._isFeedbackRequired)
            Try
                objAccess.ExecuteNonQuery("PM_Notes_Add")
                intReturn = CInt(CType(objAccess.Parameters("@ReturnValue"), System.Data.SqlClient.SqlParameter).Value)
            Catch ex As Exception
                intReturn = 0
            Finally
                objAccess.Dispose()
            End Try
            Return intReturn

        End Function

        Public Function IdeaReminderDelete() As Integer

            Dim intReturn As Integer = 0
            Dim objAccess As DBAccess = New DBAccess()
            objAccess.AddParameter("@ID", SqlDbType.Int, 4, ParameterDirection.Input, Me._Id)
            objAccess.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, intReturn)
            Try
                objAccess.ExecuteNonQuery("research_Reminder_Delete")
                intReturn = CInt(CType(objAccess.Parameters("@ReturnValue"), System.Data.SqlClient.SqlParameter).Value)
            Catch ex As Exception
                intReturn = 0
            Finally
                objAccess.Dispose()
            End Try
            Return intReturn

        End Function

        Public Function SaveAttachmentsTelerik(ByVal DirectoryName As String, ByVal Attachment As Telerik.WebControls.UploadedFile) As Integer
            Dim strAlbumPath As String = HttpContext.Current.Server.MapPath(ConfigurationManager.AppSettings("PMAttachmentPath") & DirectoryName)
            If strAlbumPath.Contains("\MyNetsolace\") Then
                strAlbumPath = strAlbumPath.Replace("\MyNetsolace\", "\")
            End If
            If My.Computer.FileSystem.DirectoryExists(strAlbumPath) = False Then
                My.Computer.FileSystem.CreateDirectory(strAlbumPath)
            End If
            If Attachment.GetName.Trim() <> String.Empty Then
                FileName = Functions.MakeFileNameValid(Attachment.GetName)
                FilePath = DirectoryName & "\" & FileName
                Attachment.SaveAs(strAlbumPath & "\" & FileName)
                Return Me.AddAttachments()
            End If
        End Function

        Public Function SaveAttachmentsTelerik(ByVal DirectoryName As String, ByVal Attachment As Telerik.WebControls.UploadedFile, ByVal Type As Integer) As Integer
            Dim strAlbumPath As String = HttpContext.Current.Server.MapPath(ConfigurationManager.AppSettings("PMAttachmentPath") & DirectoryName)
            If strAlbumPath.Contains("\MyNetsolace\") Then
                strAlbumPath = strAlbumPath.Replace("\MyNetsolace\", "\")
            End If
            If My.Computer.FileSystem.DirectoryExists(strAlbumPath) = False Then
                My.Computer.FileSystem.CreateDirectory(strAlbumPath)
            End If
            If Attachment.GetName.Trim() <> String.Empty Then
                FileName = Functions.MakeFileNameValid(Attachment.GetName)
                FilePath = DirectoryName & "\" & FileName
                AttachmentType = Type
                Attachment.SaveAs(strAlbumPath & "\" & FileName)
                Return Me.AddAttachments()
            End If
        End Function

        Public Function AddAttachments() As Integer

            Dim intReturn As Integer = 0
            Dim objAccess As DBAccess = New DBAccess()
            objAccess.AddParameter("@NotesID", SqlDbType.Int, 4, ParameterDirection.Input, Me._notesId)
            objAccess.AddParameter("@Filename", SqlDbType.VarChar, 200, ParameterDirection.Input, Me._fileName)
            objAccess.AddParameter("@Filepath", SqlDbType.VarChar, 1000, ParameterDirection.Input, Me._filePath)
            objAccess.AddParameter("@DateEntered", SqlDbType.DateTime, 8, ParameterDirection.Input, Me._dateEntered)
            objAccess.AddParameter("@AttachmentType", SqlDbType.Int, 4, ParameterDirection.Input, Me.AttachmentType)
            objAccess.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, intReturn)
            Try
                objAccess.ExecuteNonQuery("PM_NotesAttachment_Add")
                intReturn = CInt(CType(objAccess.Parameters("@ReturnValue"), System.Data.SqlClient.SqlParameter).Value)
            Catch ex As Exception
                intReturn = 0
            Finally
                objAccess.Dispose()
            End Try
            Return intReturn

        End Function

        Public Function PM_GetAttachementsByID(ByVal ID As Integer) As SqlDataReader
            Dim objAccess As DBAccess = New DBAccess()
            objAccess.AddParameter("@ID", SqlDbType.Int, 4, ParameterDirection.Input, ID)
            Return objAccess.ExecuteReader("PM_Attachments_GetByNoteID")
        End Function

        Public Function PM_GetAttachementsByTicketID(ByVal ID As Integer) As SqlDataReader
            Dim objAccess As DBAccess = New DBAccess()
            objAccess.AddParameter("@ID", SqlDbType.Int, 4, ParameterDirection.Input, ID)
            Return objAccess.ExecuteReader("PM_Ticket_Features_Attachments_GetByID")
        End Function

        Public Function GetDetailByID(ByVal TicketId As Integer) As DataSet
            Dim objDbManager As New DbManager()
            Dim ds As New DataSet
            objDbManager.AddParameter("@TicketId", TicketId)
            ds = objDbManager.ExecuteDataSet("PM_Notes_GetByTicketID")
            ds.Tables(0).TableName = "Notes"
            ds.Tables(1).TableName = "Attachments"
            ds.Relations.Add("Notes_Attachments", ds.Tables("Notes").Columns("ID"), ds.Tables("Attachments").Columns("NoteID"), False)
            Return ds
        End Function

        Public Function Notes_Update(ByVal NoteID As Integer, ByVal Type As Boolean) As Integer
            Dim db As DBAccess = New DBAccess()
            Dim Affected As Integer
            db.AddParameter("@NotesID", NoteID)
            db.AddParameter("@Type", Type)

            Try
                Affected = db.ExecuteNonQuery("PM_Notes_Update")
            Catch ex As Exception
                Throw ex
            Finally
                db.Dispose()
            End Try

            Return Affected
        End Function

    End Class
End Namespace



