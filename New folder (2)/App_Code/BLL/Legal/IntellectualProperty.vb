Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web

Public Class IntellectualProperty
#Region "Protected Variables"
    'Variables for IP
    Protected _LID As Integer
    Protected _Title As String
    Protected _Type As Integer
    Protected _DateFirstUsed As Nullable(Of DateTime)
    Protected _DateApplied As Nullable(Of DateTime)
    Protected _Firm As Nullable(Of Integer)
    Protected _ContactID As Nullable(Of Integer)
    Protected _Status As Integer
    Protected _SerialNo As String = ""
    Protected _RegNo As String = ""
    Protected _Notification As Integer
    Protected _TimeSpent As String
    Protected _AssignedTo As Nullable(Of Integer)
    Protected _ExpiresOn As Nullable(Of DateTime)
    Protected _IPDate As DateTime
    Protected _Description As String
    Protected _Legal_Country As Integer
    Protected _RefNo As String
    Protected _OwnerID As Nullable(Of Integer)
    Protected _ExpiresOnTo As Nullable(Of DateTime)
    Protected _DeclarationOfUseFrom As Nullable(Of DateTime)
    Protected _DeclarationOfUseTo As Nullable(Of DateTime)
    Protected _CreationDate As Nullable(Of DateTime)
    Protected _RegistrationDate As Nullable(Of DateTime)
    Protected _PbulishedForOpposition As Nullable(Of DateTime)
    Protected _LastActivity As DateTime

    'Variables for Activities
    Protected _AID As Integer
    Protected _Date As Nullable(Of DateTime)
    Protected _CloseDate As Nullable(Of DateTime)
    Protected _AType As Integer
    Protected _SubType As Integer
    Protected _Subject As String
    Protected _AStatus As Integer
    Protected _ActivityState As Integer
    Protected _Deleted As Boolean
    Protected _WaitingFor As Nullable(Of Integer)
    Protected _LastWaitingFor As Nullable(Of Integer)
    Protected _AAdminID As Integer

    'Variables for activity Notes
    Protected _NID As Integer
    Protected _NType As Integer
    Protected _Note As String
    Protected _NDate As DateTime
    Protected _AdminID As Integer
    Protected _ActivityAssignedTo As Nullable(Of Integer)
    Protected _ActivityTimeSpent As TimeSpan
    Protected _Reminder As Boolean
    Protected _ReminderTime As DateTime
    Protected _Cost As Decimal



    'variables for Attachments
    Protected _File1 As FileUpload
    Protected _File2 As FileUpload
    Protected _File3 As FileUpload
#End Region

#Region "Public Properties"
#Region "Legal IP Properties"
    Public Property Description() As String
        Get
            Return _Description
        End Get
        Set(ByVal value As String)
            _Description = value
        End Set
    End Property
    Public Property LID() As Integer
        Get
            Return _LID
        End Get
        Set(ByVal value As Integer)
            _LID = value
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

    Public Property Type() As Integer
        Get
            Return _Type
        End Get
        Set(ByVal value As Integer)
            _Type = value
        End Set
    End Property

    Public Property DateFirstUsed() As DateTime
        Get
            Return _DateFirstUsed
        End Get
        Set(ByVal value As DateTime)
            _DateFirstUsed = value
        End Set
    End Property

    Public Property DateApplied() As DateTime
        Get
            Return _DateApplied
        End Get
        Set(ByVal value As DateTime)
            _DateApplied = value
        End Set
    End Property

    Public Property Firm() As Integer
        Get
            Return _Firm
        End Get
        Set(ByVal value As Integer)
            _Firm = value
        End Set
    End Property
    Public Property ContactID() As Integer
        Get
            Return _ContactID
        End Get
        Set(ByVal value As Integer)
            _ContactID = value
        End Set
    End Property

    Public Property Status() As Integer
        Get
            Return _Status
        End Get
        Set(ByVal value As Integer)
            _Status = value
        End Set
    End Property

    Public Property SerialNo() As String
        Get
            Return _SerialNo
        End Get
        Set(ByVal value As String)
            _SerialNo = value
        End Set
    End Property
    Public Property RegNo() As String
        Get
            Return _RegNo
        End Get
        Set(ByVal value As String)
            _RegNo = value
        End Set
    End Property
#End Region
    Public Property ExpiresOn() As DateTime
        Get
            Return _ExpiresOn
        End Get
        Set(ByVal value As DateTime)
            _ExpiresOn = value
        End Set
    End Property
    Public Property AssignedTo() As Integer
        Get
            Return _AssignedTo
        End Get
        Set(ByVal value As Integer)
            _AssignedTo = value
        End Set
    End Property
    Public Property Notification() As Integer
        Get
            Return _Notification
        End Get
        Set(ByVal value As Integer)
            _Notification = value
        End Set
    End Property
    Public Property IPDate() As DateTime
        Get
            Return _IPDate
        End Get
        Set(ByVal value As DateTime)
            _IPDate = value
        End Set
    End Property

    Public Property Legal_Country() As Integer
        Get
            Return _Legal_Country
        End Get
        Set(ByVal value As Integer)
            _Legal_Country = value
        End Set
    End Property

    Public Property RefNo() As String
        Get
            Return _RefNo
        End Get
        Set(ByVal value As String)
            _RefNo = value
        End Set
    End Property

    Public Property OwnerID() As Integer
        Get
            Return _OwnerID
        End Get
        Set(ByVal value As Integer)
            _OwnerID = value
        End Set
    End Property

    Public Property ExpiresOnTo() As DateTime
        Get
            Return _ExpiresOnTo
        End Get
        Set(ByVal value As DateTime)
            _ExpiresOnTo = value
        End Set
    End Property

    Public Property DeclarationOfUseFrom() As DateTime
        Get
            Return _DeclarationOfUseFrom
        End Get
        Set(ByVal value As DateTime)
            _DeclarationOfUseFrom = value
        End Set
    End Property

    Public Property DeclarationOfUseTo() As DateTime
        Get
            Return _DeclarationOfUseTo
        End Get
        Set(ByVal value As DateTime)
            _DeclarationOfUseTo = value
        End Set
    End Property

    Public Property CreationDate() As DateTime
        Get
            Return _CreationDate
        End Get
        Set(ByVal value As DateTime)
            _CreationDate = value
        End Set
    End Property

    Public Property RegistrationDate() As DateTime
        Get
            Return _RegistrationDate
        End Get
        Set(ByVal value As DateTime)
            _RegistrationDate = value
        End Set
    End Property

    Public Property PbulishedForOpposition() As DateTime
        Get
            Return _PbulishedForOpposition
        End Get
        Set(ByVal value As DateTime)
            _PbulishedForOpposition = value
        End Set
    End Property
    Public Property LastActivity() As DateTime
        Get
            Return _LastActivity
        End Get
        Set(ByVal value As DateTime)
            _LastActivity = value
        End Set
    End Property

#Region "Activities Property"
    Public Property AID() As Integer
        Get
            Return _AID
        End Get
        Set(ByVal value As Integer)
            _AID = value
        End Set
    End Property

    Public Property ADate() As DateTime
        Get
            Return _Date
        End Get
        Set(ByVal value As DateTime)
            _Date = value
        End Set
    End Property

    Public Property CloseDate() As DateTime
        Get
            Return _CloseDate
        End Get
        Set(ByVal value As DateTime)
            _CloseDate = value
        End Set
    End Property

    Public Property AType() As Integer
        Get
            Return _AType
        End Get
        Set(ByVal value As Integer)
            _AType = value
        End Set
    End Property

    Public Property SubType() As Integer
        Get
            Return _SubType
        End Get
        Set(ByVal value As Integer)
            _SubType = value
        End Set
    End Property

    Public Property Subject() As String
        Get
            Return _Subject
        End Get
        Set(ByVal value As String)
            _Subject = value
        End Set
    End Property

    Public Property AStatus() As Integer
        Get
            Return _AStatus
        End Get
        Set(ByVal value As Integer)
            _AStatus = value
        End Set
    End Property

    Public Property ActivityState() As Integer
        Get
            Return _ActivityState
        End Get
        Set(ByVal value As Integer)
            _ActivityState = value
        End Set
    End Property

    Public Property Deleted() As Boolean
        Get
            Return _Deleted
        End Get
        Set(ByVal value As Boolean)
            _Deleted = value
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

    Public Property LastWaitingFor() As Integer
        Get
            Return _LastWaitingFor
        End Get
        Set(ByVal value As Integer)
            _LastWaitingFor = value
        End Set
    End Property
    Public Property AAdimnID() As Integer
        Get
            Return _AAdminID
        End Get
        Set(ByVal value As Integer)
            _AAdminID = value
        End Set
    End Property

#End Region

#Region "Activity Notes Properties"
    Public Property NID() As Integer
        Get
            Return _NID
        End Get
        Set(ByVal value As Integer)
            _NID = value
        End Set
    End Property

    Public Property NType() As Integer
        Get
            Return _NType
        End Get
        Set(ByVal value As Integer)
            _NType = value
        End Set
    End Property

    Public Property Note() As String
        Get
            Return _Note
        End Get
        Set(ByVal value As String)
            _Note = value
        End Set
    End Property

    Public Property NDate() As DateTime
        Get
            Return _NDate
        End Get
        Set(ByVal value As DateTime)
            _NDate = value
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

    Public Property Cost() As Decimal
        Get
            Return _Cost
        End Get
        Set(ByVal value As Decimal)
            _Cost = value
        End Set
    End Property

#End Region
    'Protected _ActivityAssignedTo As Integer
    'Protected _ActivityTimeSpent As TimeSpan
    'Protected _Reminder As Boolean
    'Protected _ReminderTime As DateTime

    Public Property ActivityAsssignedTo() As Integer
        Get
            Return _ActivityAssignedTo
        End Get
        Set(ByVal value As Integer)
            _ActivityAssignedTo = value
        End Set
    End Property

    Public Property ActivityTimeSpent() As TimeSpan
        Get
            Return _ActivityTimeSpent
        End Get
        Set(ByVal value As TimeSpan)
            _ActivityTimeSpent = value
        End Set
    End Property

    Public Property Reminder() As Boolean
        Get
            Return _Reminder
        End Get
        Set(ByVal value As Boolean)
            _Reminder = value
        End Set
    End Property

    Public Property ReminderTime() As DateTime
        Get
            Return _ReminderTime
        End Get
        Set(ByVal value As DateTime)
            _ReminderTime = value
        End Set
    End Property

#Region "Attachment Properties"
    Public Property File1() As FileUpload
        Get
            Return _File1
        End Get
        Set(ByVal value As FileUpload)
            _File1 = value
        End Set
    End Property

    Public Property File2() As FileUpload
        Get
            Return _File2
        End Get
        Set(ByVal value As FileUpload)
            _File2 = value
        End Set
    End Property

    Public Property File3() As FileUpload
        Get
            Return _File3
        End Get
        Set(ByVal value As FileUpload)
            _File3 = value
        End Set
    End Property
#End Region
#End Region

#Region "Methods"
    Public Function AddNewLegalIP() As Integer
        Dim db As New DBAccess
        'db.AddParameter("@ID", SqlDbType.Int, 4, ParameterDirection.Output, 0)
        db.AddParameter("@Value", SqlDbType.Int, 4, ParameterDirection.Output, 0)

        db.AddParameter("@Title", _Title)
        db.AddParameter("@Type", _Type)
        If _AssignedTo.HasValue Then
            If _AssignedTo.Value > 0 Then
                db.AddParameter("@AssignedTo", _AssignedTo)
            Else
                db.AddParameter("@AssignedTo", 0)
            End If

        End If

        db.AddParameter("@AdminID", _AdminID)
        If _DateFirstUsed.HasValue Then
            db.AddParameter("@DateFirstUsed", _DateFirstUsed)
        Else
            db.AddParameter("@DateFirstUsed", DBNull.Value)
        End If

        If _DateApplied.HasValue Then
            db.AddParameter("@DateApplied", _DateApplied)
        Else
            db.AddParameter("@DateApplied", DBNull.Value)
        End If
        If _Firm.HasValue Then
            If _Firm.Value > 0 Then
                db.AddParameter("@Firm", _Firm)
                db.AddParameter("@ContactID", _ContactID)
            Else
                db.AddParameter("@Firm", 0)
                db.AddParameter("@ContactID", 0)
            End If

        End If
        db.AddParameter("@Status", _Status)

        If _SerialNo.Length < 1 Then
            db.AddParameter("@SerialNo", DBNull.Value)
        Else
            db.AddParameter("@SerialNo", _SerialNo)
        End If
        If _RegNo.Length < 1 Then
            db.AddParameter("@RegistrationNo", DBNull.Value)
        Else
            db.AddParameter("@RegistrationNo", _RegNo)
        End If

        If _Date.HasValue Then
            db.AddParameter("@Date", _Date)
        Else
            db.AddParameter("@Date", DBNull.Value)
        End If

        If _ExpiresOn.HasValue Then
            db.AddParameter("@ExpiresOn", _ExpiresOn)
        Else
            db.AddParameter("@ExpiresOn", DBNull.Value)
        End If

        db.AddParameter("@Notification", _Notification)
        db.AddParameter("@Note", _Note)
        db.AddParameter("@Legal_CountryID", _Legal_Country)

        If _RefNo.Length < 1 Then
            db.AddParameter("@RefNo", DBNull.Value)
        Else
            db.AddParameter("@RefNo", _RefNo)
        End If

        db.AddParameter("OwnerID", _OwnerID)

        If _ExpiresOnTo.HasValue Then
            db.AddParameter("@ExpiresOnTo", _ExpiresOnTo)
        Else
            db.AddParameter("@ExpiresOnTo", DBNull.Value)
        End If

        If _DeclarationOfUseFrom.HasValue Then
            db.AddParameter("@DeclarationOfUseFrom", _DeclarationOfUseFrom)
        Else
            db.AddParameter("@DeclarationOfUseFrom", DBNull.Value)
        End If

        If _DeclarationOfUseTo.HasValue Then
            db.AddParameter("@DeclarationOfUseTo", _DeclarationOfUseTo)
        Else
            db.AddParameter("@DeclarationOfUseTo", DBNull.Value)
        End If

        If _CreationDate.HasValue Then
            db.AddParameter("@CreationDate", _CreationDate)
        Else
            db.AddParameter("@CreationDate", DBNull.Value)
        End If

        If _RegistrationDate.HasValue Then
            db.AddParameter("@RegistrationDate", _RegistrationDate)
        Else
            db.AddParameter("@RegistrationDate", DBNull.Value)
        End If

        If _PbulishedForOpposition.HasValue Then
            db.AddParameter("@PbulishedForOpposition", _PbulishedForOpposition)
        Else
            db.AddParameter("@PbulishedForOpposition", DBNull.Value)
        End If

        db.ExecuteReader("Legal_NewLegalIP")

        Return CInt(CType(db.Parameters("@Value"), System.Data.SqlClient.SqlParameter).Value)
        'Dim retNID As Integer = CInt(CType(db.Parameters("@NID"), System.Data.SqlClient.SqlParameter).Value)

        'If File1.FileName <> "" Then
        '    SaveAttachment(File1, retID, retNID)
        'End If
        'If File2.FileName <> "" Then
        '    SaveAttachment(File2, retID, retNID)
        'End If
        'If File3.FileName <> "" Then
        '    SaveAttachment(File3, retID, retNID)
        'End If
        db.Dispose()

    End Function

    Public Function GetAllLegalIPs(ByVal FirmID As Nullable(Of Integer), ByVal Type As Nullable(Of Integer), ByVal Status As Nullable(Of Integer), ByVal SortExpression As String, ByVal Country As Nullable(Of Integer), ByVal Search As String, ByVal startRowIndex As Integer, ByVal MaximumRows As Integer) As DataSet
        Dim db As DBAccess = New DBAccess()
        If FirmID.HasValue Then
            If FirmID.Value <= 0 Then
                db.AddParameter("@Firm", DBNull.Value)
            Else
                db.AddParameter("@Firm", FirmID.Value)
            End If
        End If

        If Type.HasValue Then
            If Type.Value <= 0 Then
                db.AddParameter("@Type", DBNull.Value)
            Else
                db.AddParameter("@Type", Type.Value)
            End If
        End If

        If Status.HasValue Then
            If Status.Value <= 0 Then
                db.AddParameter("@Status", DBNull.Value)
            Else
                db.AddParameter("@Status", Status.Value)

            End If

        End If

        If Country.HasValue Then
            If Country.Value <= 0 Then
                db.AddParameter("@Country", DBNull.Value)
            Else
                db.AddParameter("@Country", Country.Value)

            End If
        End If

        If Search = "" Then
            db.AddParameter("@Search", DBNull.Value)
        Else

            db.AddParameter("@Search", Search)
        End If

        db.AddParameter("@SortExpression", SortExpression)

        db.AddParameter("@startRowIndex", startRowIndex)
        db.AddParameter("@maximumRows", MaximumRows)
        Return CType(db.ExecuteDataSet("Legal_GetAllIP"), DataSet)
    End Function

    Public Function GetAllLegalIPsCount(ByVal FirmID As Nullable(Of Integer), ByVal Type As Nullable(Of Integer), ByVal Status As Nullable(Of Integer), ByVal SortExpression As String, ByVal Country As Nullable(Of Integer), Optional ByVal Search As String = "") As Integer
        Dim db As DBAccess = New DBAccess()
        If FirmID.HasValue Then
            If FirmID.Value <= 0 Then
                db.AddParameter("@Firm", DBNull.Value)
            Else
                db.AddParameter("@Firm", FirmID.Value)
            End If
        End If

        If Type.HasValue Then
            If Type.Value <= 0 Then
                db.AddParameter("@Type", DBNull.Value)
            Else
                db.AddParameter("@Type", Type.Value)
            End If
        End If

        If Status.HasValue Then
            If Status.Value <= 0 Then
                db.AddParameter("@Status", DBNull.Value)
            Else
                db.AddParameter("@Status", Status.Value)

            End If

        End If

        If Country.HasValue Then
            If Country.Value <= 0 Then
                db.AddParameter("@Country", DBNull.Value)
            Else
                db.AddParameter("@Country", Country.Value)

            End If
        End If

        If Search = "" Then
            db.AddParameter("@Search", DBNull.Value)
        Else

            db.AddParameter("@Search", Search)
        End If
        Return CType(db.ExecuteScalar("Legal_GetAllIPCount"), Integer)
    End Function

    Public Shared Function GetLegalStatusID(ByVal StatusID As Integer) As String
        Dim retVal As String = ""
        Select Case StatusID
            Case Legal_Enumerations.LegalIPStatus.Pending
                retVal = "Pending"
            Case Legal_Enumerations.LegalIPStatus.Applied
                retVal = "Applied"
            Case Legal_Enumerations.LegalIPStatus.Approved
                retVal = "Approved"
            Case Legal_Enumerations.LegalIPStatus.Opposed
                retVal = "Opposed"
        End Select
        Return retVal
    End Function 'enumeration function

    Public Shared Function GetLegalTypeID(ByVal StatusID As Integer) As String
        Dim retVal As String = ""
        Select Case StatusID
            Case Legal_Enumerations.LegalIPType.TradeMark
                retVal = "Trademark"
            Case Legal_Enumerations.LegalIPType.Patent
                retVal = "Patent"
            Case Legal_Enumerations.LegalIPType.CopyRight
                retVal = "Copyright"
        End Select
        Return retVal
    End Function 'enumeration function

    Public Shared Function GetActivityStateID(ByVal StatusID As Integer) As String
        Dim retVal As String = ""
        Select Case StatusID
            Case Legal_Enumerations.ActivityState.NotStarted
                retVal = "Not Started"
            Case Legal_Enumerations.ActivityState.InProgress
                retVal = "In Progress"
            Case Legal_Enumerations.ActivityState.Complete
                retVal = "Complete"
            Case Legal_Enumerations.ActivityState.WaitingFor
                retVal = "Waiting for"
        End Select
        Return retVal
    End Function 'enumeration function

    Public Shared Function GetNoteTypeID(ByVal StatusID As Integer) As String
        Dim retVal As String = ""
        Select Case StatusID
            Case Legal_Enumerations.NoteType.Call1
                retVal = "Call"
            Case Legal_Enumerations.NoteType.Application
                retVal = "Application"
            Case Legal_Enumerations.NoteType.Letter
                retVal = "Letter"
            Case Legal_Enumerations.NoteType.Fax
                retVal = "Fax"
            Case Legal_Enumerations.NoteType.Meeting
                retVal = "Meeting"
            Case Legal_Enumerations.NoteType.Other
                retVal = "Other"
            Case Else
                retVal = "Other"
        End Select
        Return retVal
    End Function 'enumeration function

    Public Function GetLegalActivities(ByVal ID As Integer, ByVal Status As Integer, ByVal StartDate As Nullable(Of DateTime), ByVal CloseDate As Nullable(Of DateTime), Optional ByVal Search As String = "") As SqlDataReader
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ID", ID)
        db.AddParameter("@Status", Status)
        db.AddParameter("@Search", Search)
        If StartDate.HasValue Then
            db.AddParameter("@StartDate", StartDate)
        Else
            db.AddParameter("@StartDate", DBNull.Value)
        End If

        If CloseDate.HasValue Then
            db.AddParameter("@CloseDate", CloseDate)
        Else
            db.AddParameter("@CloseDate", DBNull.Value)
        End If
        Return CType(db.ExecuteReader("Legal_GetLegalActivities"), SqlDataReader)
        db.Dispose()
    End Function

    Public Function AddLegalActivity() As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@AID", SqlDbType.Int, 4, ParameterDirection.Output, 0)
        db.AddParameter("@NID", SqlDbType.Int, 4, ParameterDirection.Output, 0)
        db.AddParameter("@IPID", _LID)
        db.AddParameter("@Type", _NType)
        db.AddParameter("@Note", _Note)
        db.AddParameter("@Status", _AStatus)
        db.AddParameter("@ActivityState", _ActivityState)
        db.AddParameter("@TimeSpent", _ActivityTimeSpent.ToString())
        db.AddParameter("@ActivityAssignedTo", _ActivityAssignedTo)
        db.AddParameter("@Subject", _Subject)

        db.AddParameter("@UserID", _AdminID)
        If _CloseDate.HasValue Then
            db.AddParameter("@CloseDate", _CloseDate)
        Else
            db.AddParameter("@CloseDate", DBNull.Value)
        End If

        If _AssignedTo.HasValue Then
            If _AssignedTo.Value > 0 Then
                db.AddParameter("@Assigned", _ActivityAssignedTo)
            Else
                db.AddParameter("@Assigned", DBNull.Value)
            End If
        End If
        db.ExecuteNonQuery("Legal_AddActivity")
        Dim retNID As Integer
        retNID = CInt(CType(db.Parameters("@NID"), System.Data.SqlClient.SqlParameter).Value)
        Dim retAID As Integer
        retAID = CInt(CType(db.Parameters("@AID"), System.Data.SqlClient.SqlParameter).Value)
        Me.UpdateIPTime()
        If File1.FileName <> "" Then
            SaveAttachment(File1, retAID, retNID)
        End If
        If File2.FileName <> "" Then
            SaveAttachment(File2, retAID, retNID)
        End If
        If File3.FileName <> "" Then
            SaveAttachment(File3, retAID, retNID)
        End If
        Return retAID
    End Function

    Public Shared Function Legal_GetAdminName(ByVal AdminId As Integer) As String
        Dim db As DBAccess = New DBAccess()
        If AdminId > 0 Then
            db.AddParameter("@UserId", AdminId)
            Dim dr As SqlDataReader = CType(db.ExecuteReader("Users_GetAllByID"), SqlDataReader)
            If dr.HasRows Then
                dr.Read()
                Dim fname As String = dr.Item(3).ToString()
                Dim lname As String = dr.Item(4).ToString()
                Return fname + " " + lname
            Else
                dr.Close()
                Return "NONE"
            End If
            dr.Close()
        Else
            Return "NONE"

        End If
    End Function

    'Public Shared Function Legal_FirmCountryName(ByVal CountryID As Integer) As String
    '    Dim db As DBAccess = New DBAccess()
    '    db.AddParameter("@CountryID", CountryID)
    '    Dim dr As SqlDataReader = CType(db.ExecuteReader("Countries_GetByID"), SqlDataReader)
    '    If dr.HasRows Then
    '        dr.Read()
    '        Return dr.Item(2).ToString()
    '    Else
    '        Return ""
    '    End If

    'End Function

    'Public Shared Function Legal_FirmStateName(ByVal StateID As Integer) As String
    '    Dim db As DBAccess = New DBAccess()
    '    db.AddParameter("@stateID", StateID)
    '    Dim dr As SqlDataReader = CType(db.ExecuteReader("States_GetByID_ForAdmin"), SqlDataReader)
    '    If dr.HasRows Then
    '        dr.Read()
    '        Return dr.Item(3).ToString()
    '    Else
    '        Return ""
    '    End If

    'End Function

    Public Shared Function Legal_GetSingleIP(ByVal ID As Integer) As SqlDataReader
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ID", ID)
        Return CType(db.ExecuteReader("Legal_GetIPByID"), SqlDataReader)


    End Function
    Public Shared Function Legal_GetSingleIPName(ByVal ID As Integer) As String
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ID", ID)
        Dim dr As SqlDataReader = CType(db.ExecuteReader("Legal_GetIPByID"), SqlDataReader)
        If dr.HasRows Then
            dr.Read()
            Return dr.Item("Title").ToString()
        Else
            dr.Close()
            Return ""
        End If
    End Function


    Public Function AddActivityNote() As Integer
        Dim db As DBAccess = New DBAccess()

        db.AddParameter("@ID", SqlDbType.Int, 4, ParameterDirection.Output, 0)
        db.AddParameter("@ActivityID", _AID)
        db.AddParameter("@NType", _NType)
        db.AddParameter("@Notes", _Note)
        db.AddParameter("@UserId", _AdminID)
        db.AddParameter("@Reminder", _Reminder)
        If Not ReminderTime = Nothing Then
            db.AddParameter("@ReminderTime", _ReminderTime)
        End If

        db.AddParameter("@AssignedTo", _ActivityAssignedTo)
        db.AddParameter("@TimeSpent", _ActivityTimeSpent.ToString())
        db.AddParameter("@Cost", _Cost)
        db.ExecuteNonQuery("Legal_AddActivityNote")
        Dim retNID As Integer
        retNID = CInt(CType(db.Parameters("@ID"), System.Data.SqlClient.SqlParameter).Value)
        If File1 IsNot Nothing AndAlso File1.FileName <> "" Then
            SaveAttachment(File1, _AID, retNID)
        End If
        If File2 IsNot Nothing AndAlso File2.FileName <> "" Then
            SaveAttachment(File2, _AID, retNID)
        End If
        If File3 IsNot Nothing AndAlso File3.FileName <> "" Then
            SaveAttachment(File3, _AID, retNID)
        End If
    End Function

    Public Function SaveAttachment(ByRef file As FileUpload, ByVal ActivityID As Integer, ByVal NoteID As Integer) As Integer
        Dim FolderId As String = Replace(Replace(Replace(Now(), ":", ""), " ", ""), "/", "")
        Dim Path As String = ConfigurationManager.AppSettings("IPAttachPath") & FolderId

        System.IO.Directory.CreateDirectory(HttpContext.Current.Server.MapPath(Path))
        file.SaveAs(HttpContext.Current.Server.MapPath(Path & "/") & Functions.MakeFileNameValid(file.FileName))
        Return CInt(Me.AddAttachment(ActivityID, NoteID, FolderId, file))

    End Function

    Public Function AddAttachment(ByVal ActivityID As Integer, ByVal NoteID As Integer, ByVal FolderId As String, ByRef File As FileUpload) As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ActivityID", ActivityID)
        db.AddParameter("@FilePath", FolderId & "\" & Functions.MakeFileNameValid(File.FileName))
        db.AddParameter("NoteID", NoteID)
        Return CInt(db.ExecuteNonQuery("Legal_ActivityNoteAttachments"))
    End Function

    Public Function GetSingleActivity(ByVal ID As Integer)
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ID", ID)
        Return CType(db.ExecuteReader("LegaL_GetSingleLegalActivity"), SqlDataReader)
    End Function

    Public Function GetNotesByActivtyID(ByVal ActivityID As Integer) As DataSet
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ActivityID", ActivityID)
        Dim ds As DataSet = db.ExecuteDataSet("Legal_GetNotesByActivtyID")
        ds.Tables(0).TableName = "Notes"
        ds.Tables(1).TableName = "Attachments"
        ds.Relations.Add("NOTE_ATTACH", ds.Tables("Notes").Columns("ID"), ds.Tables("Attachments").Columns("NoteID"))
        Return ds
    End Function
    Public Shared Function GetTicketNumber(ByVal Type As Integer, ByVal ID As Integer) As String
        Dim prefix As String = ""
        If Legal_Enumerations.NoteType.Application = Type Then
            prefix = "A" & ID.ToString()
        End If
        If Legal_Enumerations.NoteType.Call1 = Type Then
            prefix = "C" & ID.ToString()
        End If
        If Legal_Enumerations.NoteType.Fax = Type Then
            prefix = "F" & ID.ToString()
        End If
        If Legal_Enumerations.NoteType.Letter = Type Then
            prefix = "L" & ID.ToString()
        End If
        If Legal_Enumerations.NoteType.Meeting = Type Then
            prefix = "M" & ID.ToString()
        End If
        If Legal_Enumerations.NoteType.Other = Type Then
            prefix = "O" & ID.ToString()
        End If
        Return prefix
    End Function
    Public Function Legal_GetAttachments(ByVal NoteID As Integer) As SqlDataReader
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@NoteID", NoteID)
        Return db.ExecuteReader("Legal_GetAttachments")
    End Function
    Public Shared Function GetAttachmentFileName(ByVal FilePath As String) As String
        Dim file As String()
        file = FilePath.Split("\")
        Return file(1)
    End Function
    Public Function UpdateIPStatus() As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ActivityID", _AID)
        db.AddParameter("@ActivityState", _ActivityState)
        If _WaitingFor.HasValue Then
            If _WaitingFor.Value > 0 Then
                db.AddParameter("@WaitingFor", _WaitingFor)
            Else
                db.AddParameter("@WaitingFor", DBNull.Value)
            End If
        End If
        Return db.ExecuteNonQuery("Legal_UpdateIPStatus")
    End Function

    Public Sub UpdateTimeSpent(ByVal ID As Integer, ByVal TimeSpent As TimeSpan)
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ID", ID)
        Dim totalMins As Long = TimeSpent.TotalMinutes
        'Dim totalHours As Long = Math.Floor(TimeSpent.TotalHours)
        Dim strTotalHours As String = Math.Floor(TimeSpent.TotalHours).ToString()
        If (strTotalHours.Length < 2) Then
            strTotalHours = "0" + strTotalHours
        End If
        totalMins = totalMins Mod 60
        db.AddParameter("@TimeSpent", strTotalHours & ":" & totalMins)
        db.ExecuteNonQuery("Legal_UpdateActivityTimeSpent")
    End Sub
    Public Shared Function GetTimeSpent(ByVal time As String) As String
        If time <> "" Then
            Dim ntime As String() = time.Split(":")
            Return ntime(0) & " Hrs " & ntime(1) & " Mins "
        Else
            Return ""
        End If
    End Function
    Public Function Legal_Search(ByVal Search As String) As SqlDataReader
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@Search", Search)
        Return CType(db.ExecuteReader("Legal_Search"), SqlDataReader)

    End Function
    Public Shared Function TrimSearchResults(ByVal Result As String) As String
        If Result.Length > 29 Then
            Return Result.Substring(0, 27) & "..."
        Else
            Return Result
        End If
    End Function
    Public Function UpdateLegalIP() As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ID", _LID)
        db.AddParameter("@Title", _Title)
        db.AddParameter("@Type", _Type)
        db.AddParameter("@UserID", _AdminID)
        If _DateFirstUsed.HasValue Then
            db.AddParameter("@DateFirstUsed", _DateFirstUsed)
        Else
            db.AddParameter("@DateFirstUsed", DBNull.Value)
        End If

        If _DateApplied.HasValue Then
            db.AddParameter("@DateApplied", _DateApplied)
        Else
            db.AddParameter("@DateApplied", DBNull.Value)
        End If

        If _Firm.HasValue Then
            If _Firm.Value > 0 Then
                db.AddParameter("@FirmID", _Firm)
                db.AddParameter("@ContactID", _ContactID)
            Else
                db.AddParameter("@FirmID", 0)
                db.AddParameter("@ContactID", 0)
            End If

        End If

        db.AddParameter("@Status", _Status)

        If _SerialNo.Length < 1 Then
            db.AddParameter("@SerialNo", DBNull.Value)
        Else
            db.AddParameter("@SerialNo", _SerialNo)
        End If
        If _RegNo.Length < 1 Then
            db.AddParameter("@RegistrationNo", DBNull.Value)
        Else
            db.AddParameter("@RegistrationNo", _RegNo)
        End If

        If _Date.HasValue Then
            db.AddParameter("@Date", _Date)
        Else
            db.AddParameter("@Date", DBNull.Value)
        End If

        If _ExpiresOn.HasValue Then
            db.AddParameter("@ExpiresOn", _ExpiresOn)
        Else
            db.AddParameter("@ExpiresOn", DBNull.Value)
        End If

        db.AddParameter("@Notification", _Notification)
        db.AddParameter("@AssignedTo", _AssignedTo)
        db.AddParameter("@Description", _Description)
        db.AddParameter("@Legal_CountryID", _Legal_Country)
        If _RefNo.Length < 1 Then
            db.AddParameter("@RefNo", DBNull.Value)
        Else
            db.AddParameter("@RefNo", _RefNo)
        End If

        db.AddParameter("OwnerID", _OwnerID)

        If _ExpiresOnTo.HasValue Then
            db.AddParameter("@ExpiresOnTo", _ExpiresOnTo)
        Else
            db.AddParameter("@ExpiresOnTo", DBNull.Value)
        End If

        If _DeclarationOfUseFrom.HasValue Then
            db.AddParameter("@DeclarationOfUseFrom", _DeclarationOfUseFrom)
        Else
            db.AddParameter("@DeclarationOfUseFrom", DBNull.Value)
        End If

        If _DeclarationOfUseTo.HasValue Then
            db.AddParameter("@DeclarationOfUseTo", _DeclarationOfUseTo)
        Else
            db.AddParameter("@DeclarationOfUseTo", DBNull.Value)
        End If

        If _CreationDate.HasValue Then
            db.AddParameter("@CreationDate", _CreationDate)
        Else
            db.AddParameter("@CreationDate", DBNull.Value)
        End If

        If _RegistrationDate.HasValue Then
            db.AddParameter("@RegistrationDate", _RegistrationDate)
        Else
            db.AddParameter("@RegistrationDate", DBNull.Value)
        End If

        If _PbulishedForOpposition.HasValue Then
            db.AddParameter("@PbulishedForOpposition", _PbulishedForOpposition)
        Else
            db.AddParameter("@PbulishedForOpposition", DBNull.Value)
        End If

        db.ExecuteNonQuery("Legal_UpdateLegalIP")
        Return 1
    End Function
    Public Function DeleteLegalIP(ByVal ID As Integer) As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ID", ID)
        db.AddParameter("@ModuleID", 1)
        Return (CInt(db.ExecuteNonQuery("Legal_DeleteLegalIP")))

    End Function
    Public Function GetIPFirmInfo(ByVal IPID As Integer) As SqlDataReader
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("ID", IPID)
        Return CType(db.ExecuteReader("Legal_GetIPFirmInfo"), SqlDataReader)
    End Function
    Public Shared Function TimeDate(ByVal TrimDate As String) As String
        If TrimDate <> "" Then
            If TrimDate <> "12/12/1900 12:00:00 AM" Then
                Return Convert.ToDateTime(TrimDate).ToShortDateString()
            End If
        Else
            Return ""
        End If
        Return ""
    End Function
    Public Sub AddActivityReminder()
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ModuleID", 1)
        db.AddParameter("@ActivityID", _AID)
        db.AddParameter("@UserId", _AdminID)
        db.AddParameter("@ReminderTime", _ReminderTime)
        db.ExecuteNonQuery("Legal_AddNewReminder")
    End Sub
    Public Sub UpdateIPTime()
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@IPID", _LID)
        db.ExecuteNonQuery("Legal_UpdateIPTime")
    End Sub
    Public Function GetIPTypes() As SqlDataReader
        Return New DBAccess().ExecuteReader("Legal_GetIPTypes")
    End Function
    Public Function GetIPStatusTypes() As SqlDataReader
        Return New DBAccess().ExecuteReader("Legal_GetIPStatusTypes")
    End Function
    Public Function UpdateIPType(ByVal ID As Integer, ByVal Name As String) As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ID", ID)
        db.AddParameter("@Name", Name)
        db.AddParameter("@Validate", SqlDbType.Int, 4, ParameterDirection.Output, 0)
        db.ExecuteNonQuery("Legal_UpdateIPType")
        Return CInt(CType(db.Parameters("@Validate"), System.Data.SqlClient.SqlParameter).Value)
    End Function
    Public Function UpdateIPStatusType(ByVal ID As Integer, ByVal Name As String) As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ID", ID)
        db.AddParameter("@Name", Name)
        db.AddParameter("@Validate", SqlDbType.Int, 4, ParameterDirection.Output, 0)
        db.ExecuteNonQuery("Legal_UpdateIPStatusType")
        Return CInt(CType(db.Parameters("@Validate"), System.Data.SqlClient.SqlParameter).Value)
    End Function
    Public Sub DeleteIPType(ByVal ID As Integer)
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ID", ID)
        db.ExecuteNonQuery("Legal_DeleteIPType")
    End Sub
    Public Sub DeleteIPStatusType(ByVal ID As Integer)
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ID", ID)
        db.ExecuteNonQuery("Legal_DeleteIPStatusType")
    End Sub
    Public Shared Function AddNewIPType(ByVal Name As String) As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@Name", Name)
        db.AddParameter("@Value", SqlDbType.Int, 4, ParameterDirection.Output, 0)
        db.ExecuteNonQuery("Legal_AddIPType")
        Return CInt(CType(db.Parameters("@Value"), System.Data.SqlClient.SqlParameter).Value)
    End Function

    Public Shared Function AddNewIPStatusType(ByVal Name As String) As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@Name", Name)
        db.AddParameter("@Value", SqlDbType.Int, 4, ParameterDirection.Output, 0)
        db.ExecuteNonQuery("Legal_AddIPStatusType")
        Return CInt(CType(db.Parameters("@Value"), System.Data.SqlClient.SqlParameter).Value)
    End Function
    Public Shared Function GetStringDate(ByVal IDate As Object) As String
       
        If Not IDate Is DBNull.Value Then
            Dim Dt As String = IDate.ToShortDateString()
            Dim split As String() = Dt.Split("/")
            If IDate.ToShortDateString() = "12/12/1900" Then
                Return ""
            Else
                Select Case CInt(split(0))
                    Case Legal_Enumerations.Months.Jan
                        Return "Jan " & split(1) & ", " & split(2)
                    Case Legal_Enumerations.Months.Feb
                        Return "Feb " & split(1) & ", " & split(2)
                    Case Legal_Enumerations.Months.Mar
                        Return "Mar " & split(1) & ", " & split(2)
                    Case Legal_Enumerations.Months.Apr
                        Return "Apr " & split(1) & ", " & split(2)
                    Case Legal_Enumerations.Months.May
                        Return "May " & split(1) & ", " & split(2)
                    Case Legal_Enumerations.Months.Jun
                        Return "Jun " & split(1) & ", " & split(2)
                    Case Legal_Enumerations.Months.Jul
                        Return "Jul " & split(1) & ", " & split(2)
                    Case Legal_Enumerations.Months.Aug
                        Return "Aug " & split(1) & ", " & split(2)
                    Case Legal_Enumerations.Months.Sep
                        Return "Sep " & split(1) & ", " & split(2)
                    Case Legal_Enumerations.Months.Oct
                        Return "Oct " & split(1) & ", " & split(2)
                    Case Legal_Enumerations.Months.Nov
                        Return "Nov " & split(1) & ", " & split(2)
                    Case Legal_Enumerations.Months.Dec
                        Return "Dec " & split(1) & ", " & split(2)
                End Select
            End If
        End If
        Return ""
    End Function

    Public Function GetActivityReminder() As SqlDataReader
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ModuleID", 1)
        db.AddParameter("@ActivityID", _AID)
        db.AddParameter("@UserId", _AdminID)
        Return db.ExecuteReader("Legal_GetActivityReminder")
    End Function
    Public Function UpdateActivityReminder(ByVal RemID As Integer, ByVal RemTime As DateTime) As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ID", RemID)
        db.AddParameter("@ReminderTime", RemTime)
        Return db.ExecuteNonQuery("Legal_UpdateActivityReminder")
    End Function
    Public Function DeleteActivityReminder(ByVal RemID As Integer) As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ID", RemID)
        Return db.ExecuteNonQuery("Legal_DeleteActivityReminder")
    End Function
    Public Shared Function TrimValue(ByVal Obj As Object) As String
        If Not Obj Is DBNull.Value Then
            If Obj.ToString().Length > 20 Then
                Return Obj.ToString().Substring(0, 20)
            Else
                Return Obj.ToString()
            End If
            Return "&nbsp;"
        End If
        Return "&nbsp;"
    End Function
#End Region
    Public Function GetIPActivityTypes() As SqlDataReader
        Return New DBAccess().ExecuteReader("Legal_GetIPActivityType")
    End Function
    Public Function UpdateIPActivityType(ByVal ID As Integer, ByVal Name As String) As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ID", ID)
        db.AddParameter("@Name", Name)
        db.AddParameter("@Validate", SqlDbType.Int, 4, ParameterDirection.Output, 0)
        db.ExecuteNonQuery("Legal_UpdateIPActivityType")
        Return CInt(CType(db.Parameters("@Validate"), System.Data.SqlClient.SqlParameter).Value)
    End Function
    Public Sub DeleteIPActivityType(ByVal ID As Integer)
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ID", ID)
        db.ExecuteNonQuery("Legal_DeleteIPActivityType")
    End Sub
    Public Shared Function AddNewIPActivityType(ByVal Name As String) As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@Name", Name)
        db.AddParameter("@Value", SqlDbType.Int, 4, ParameterDirection.Output, 0)
        db.ExecuteNonQuery("Legal_AddIPActivityType")
        Return CInt(CType(db.Parameters("@Value"), System.Data.SqlClient.SqlParameter).Value)
    End Function

    Public Sub UpdateActivityCost(ByVal ActivityID As Integer, ByVal Cost As Decimal)
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ActivityID", ActivityID)
        db.AddParameter("@Cost", Cost)
        db.ExecuteNonQuery("Legal_UpdateActivityCost")
    End Sub

    Public Function UpdateLastModified() As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@IP", Me.LID)
        db.ExecuteNonQuery("Legal_UpdateIP_LastModified")
    End Function

    Public Shared Function Legal_GetAttachmentsPathByID(ByVal ID As Integer) As SqlDataReader
        Dim dbAccess As New DBAccess
        dbAccess.AddParameter("@ID", ID)
        Return dbAccess.ExecuteReader("Legal_GetAttachmentFilePathByID")
    End Function
End Class