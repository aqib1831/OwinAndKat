Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web

Public Class CaseMgmt
    Protected _ModuleID As Integer
    Public Property ModuleID() As Integer
        Get
            Return _ModuleID
        End Get
        Set(ByVal value As Integer)
            _ModuleID = value
        End Set
    End Property
#Region "Protected Variables"
    'Variables for Case
    Protected _CID As Integer
    Protected _Title As String
    Protected _Franchisee As Integer
    Protected _Type As Integer
    Protected _AssignedTo As Nullable(Of Integer)
    Protected _DateEntered As Nullable(Of DateTime)
    Protected _DateModified As Nullable(Of DateTime)
    Protected _Firm As Integer
    Protected _Status As Integer
    Protected _FirmCaseNo As String = ""
    Protected _DocketNo As String = ""
    Protected _CaseDate As DateTime
    Protected _TotalTimeSpent As String
    Protected _TotalCost As Decimal
    Protected _ContactID As Integer
    Protected _ConcernedParties As String
    Protected _LastActivity As DateTime
    Protected _Notify As DateTime


    'Variables for Activities
    Protected _AID As Integer
    Protected _Date As Nullable(Of DateTime)
    Protected _CloseDate As Nullable(Of DateTime)
    Protected _AType As Integer
    Protected _SubType As Integer
    Protected _Subject As String
    Protected _AStatus As Integer
    Protected _ActivitySate As Integer
    Protected _Deleted As Boolean
    Protected _ACost As Decimal
    Protected _WaitingFor As Nullable(Of Integer)
    Protected _LastWaitingFor As Nullable(Of Integer)
 

    'Variables for activity Notes
    Protected _NID As Integer
    Protected _NType As Integer
    Protected _Note As String
    Protected _NDate As DateTime
    Protected _AdminID As Integer
    Protected _ActivityAssignedTo
    Protected _Reminder As Boolean
    Protected _ReminderTime As DateTime
    Protected _Cost As Decimal
    Protected _TimeSpent As String

    'variables for Attachments
    Protected _File1 As FileUpload
    Protected _File2 As FileUpload
    Protected _File3 As FileUpload
#End Region

#Region "Public Properties"
#Region "Case Properties"
    Public Property CID() As Integer
        Get
            Return _CID
        End Get
        Set(ByVal value As Integer)
            _CID = value
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
    Public Property Franchisee() As Integer
        Get
            Return _Franchisee
        End Get
        Set(ByVal value As Integer)
            _Franchisee = value
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
    Public Property AssignedTo() As Integer
        Get
            Return _AssignedTo
        End Get
        Set(ByVal value As Integer)
            _AssignedTo = value
        End Set
    End Property

    Public Property DateEntered() As DateTime
        Get
            Return _DateEntered
        End Get
        Set(ByVal value As DateTime)
            _DateEntered = value
        End Set
    End Property

    Public Property DateModified() As DateTime
        Get
            Return _DateModified
        End Get
        Set(ByVal value As DateTime)
            _DateModified = value
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

    Public Property Status() As Integer
        Get
            Return _Status
        End Get
        Set(ByVal value As Integer)
            _Status = value
        End Set
    End Property


    Public Property CaseDate() As DateTime
        Get
            Return _CaseDate
        End Get
        Set(ByVal value As DateTime)
            _CaseDate = value
        End Set
    End Property
    Public Property TotalTimeSpent() As String
        Get
            Return _TotalTimeSpent
        End Get
        Set(ByVal value As String)
            _TotalTimeSpent = value
        End Set
    End Property
    Public Property TotalCost() As Decimal
        Get
            Return _TotalCost
        End Get
        Set(ByVal value As Decimal)
            _TotalCost = value
        End Set
    End Property

    Public Property FirmCaseNo() As String
        Get
            Return _FirmCaseNo
        End Get
        Set(ByVal value As String)
            _FirmCaseNo = value
        End Set
    End Property
    Public Property DocketNo() As String
        Get
            Return _DocketNo
        End Get
        Set(ByVal value As String)
            _DocketNo = value
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
    Public Property ConcernedParties() As String
        Get
            Return _ConcernedParties
        End Get
        Set(ByVal value As String)
            _ConcernedParties = value
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
    Public Property Notify() As DateTime
        Get
            Return _Notify
        End Get
        Set(ByVal value As DateTime)
            _Notify = value
        End Set
    End Property

#End Region
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

    Public Property ActivitySate() As Integer
        Get
            Return _ActivitySate
        End Get
        Set(ByVal value As Integer)
            _ActivitySate = value
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
    Public Property ACost() As Decimal
        Get
            Return _ACost
        End Get
        Set(ByVal value As Decimal)
            _ACost = value
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
#End Region
    'Protected _ActivityAssignedTo
    'Protected _Reminder As Boolean
    'Protected _ReminderTime As DateTime
    'Protected _Cost As Decimal
    'Protected _TimeSpent As TimeSpan

    Public Property ActivityAssignedTo() As Integer
        Get
            Return _ActivityAssignedTo
        End Get
        Set(ByVal value As Integer)
            _ActivityAssignedTo = value
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
    Public Property Cost() As Decimal
        Get
            Return _Cost
        End Get
        Set(ByVal value As Decimal)
            _Cost = value
        End Set
    End Property
    Public Property TimeSpent() As String
        Get
            Return _TimeSpent
        End Get
        Set(ByVal value As String)
            _TimeSpent = value
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

    Public Function AddNewCase() As Integer

        Dim db As New DBAccess

        'db.AddParameter("@AID", SqlDbType.Int, 4, ParameterDirection.Output, 0)
        db.AddParameter("@Value", SqlDbType.Int, 4, ParameterDirection.Output, 0)

        db.AddParameter("@Title", _Title)
        If _Franchisee > 0 Then
            db.AddParameter("@Franchisee", _Franchisee)
        Else
            db.AddParameter("@Franchisee", DBNull.Value)
        End If
        db.AddParameter("@Type", _Type)
        If _AssignedTo.Value > 0 Then
            db.AddParameter("@AssignedTo", _AssignedTo)
        Else
            db.AddParameter("@AssignedTo", 0)
        End If
        If _Firm > 0 Then
            db.AddParameter("@FirmID", _Firm)
        Else
            db.AddParameter("@FirmID", 0)
        End If
        If _ContactID > 0 AndAlso _ContactID.ToString() <> "" Then
            db.AddParameter("@ContactID", _ContactID)
        Else
            db.AddParameter("@ContactID", 0)
        End If

        If _ConcernedParties.ToString() <> "" Then
            db.AddParameter("@ConcernedParties", _ConcernedParties)
        Else
            db.AddParameter("@ConcernedParties", DBNull.Value)
        End If

        db.AddParameter("@Status", _Status)

        If _FirmCaseNo.Length < 1 Then
            db.AddParameter("@FirmCaseNo", DBNull.Value)
        Else
            db.AddParameter("@FirmCaseNo", _FirmCaseNo)
        End If
        If _DocketNo.Length < 1 Then
            db.AddParameter("@DocketNo", DBNull.Value)
        Else
            db.AddParameter("@DocketNo", _DocketNo)
        End If
        If _Note.Length > 1 Then
            db.AddParameter("@Description", _Note)
        Else
            db.AddParameter("@Description", DBNull.Value)
        End If
        If CaseDate.ToString() <> "" Then
            db.AddParameter("@CaseDate", _CaseDate)
        Else
            db.AddParameter("@CaseDate", DBNull.Value)
        End If

        db.AddParameter("@UserId", _AdminID)
        db.AddParameter("@Notify", Me.Notify)
        db.ExecuteNonQuery("Legal_AddNewCase")
        Dim retVal As Integer
        retVal = CInt(CType(db.Parameters("@Value"), System.Data.SqlClient.SqlParameter).Value)
        Return retVal
        db.Dispose()
    End Function

    Public Function GetAllCases(ByVal FirmID As Nullable(Of Integer), ByVal Type As Nullable(Of Integer), ByVal Status As Nullable(Of Integer), ByVal SortExpression As String, ByVal Search As String, ByVal startRowIndex As Integer, ByVal MaximumRows As Integer) As DataSet
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
        If Search = "" Then
            db.AddParameter("@Search", DBNull.Value)
        Else

            db.AddParameter("@Search", Search)
        End If
        db.AddParameter("@SortExpression", SortExpression)
        db.AddParameter("@startRowIndex", startRowIndex)
        db.AddParameter("@maximumRows", MaximumRows)
        Return CType(db.ExecuteDataSet("Legal_GetAllCases"), DataSet)
    End Function

    Public Function GetAllCasesCount(ByVal FirmID As Nullable(Of Integer), ByVal Type As Nullable(Of Integer), ByVal Status As Nullable(Of Integer), ByVal SortExpression As String, Optional ByVal Search As String = "") As Integer
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
        If Search = "" Then
            db.AddParameter("@Search", DBNull.Value)
        Else

            db.AddParameter("@Search", Search)
        End If
        Return CType(db.ExecuteScalar("Legal_GetAllCasesCount"), Integer)
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
    End Function
    Public Function GetSingleCase(ByVal CaseID As Integer) As SqlDataReader
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@CaseID", CaseID)
        Return CType(db.ExecuteReader("Legal_GetSingleCase"), SqlDataReader)
    End Function
    Public Shared Function GetSingleCaseName(ByVal CaseID As Integer) As Object
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@CaseID", CaseID)
        Dim dr As SqlDataReader = db.ExecuteReader("Legal_GetSingleCase")
        If dr.Read Then
            Return dr.Item("Title")
            dr.Close()
        Else
            Return "&nbsp;"
            dr.Close()
        End If

    End Function
    Public Shared Function GetCaseTypeID(ByVal StatusID As Integer) As String
        Dim retVal As String = ""
        Select Case StatusID
            Case Legal_Enumerations.CaseType.Litigation
                retVal = "Litigation"
            Case Legal_Enumerations.CaseType.Arbitration
                retVal = "Arbitration"
            Case Legal_Enumerations.CaseType.GeneralProceeding
                retVal = "General Proceeding"
        End Select
        Return retVal
    End Function 'enumeration function

    Public Shared Function GetTimeSight(ByVal TimeSight As Boolean) As String
        Dim retVal As String = ""
        Select Case TimeSight
            Case Legal_Enumerations.TimeSight.Insight
                retVal = "Insight"
            Case Legal_Enumerations.TimeSight.Outsight
                retVal = "Outsight"
        End Select
        Return retVal
    End Function

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

    Public Shared Function GetActivityTypeID(ByVal StatusID As Integer) As String
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
            Case Legal_Enumerations.NoteType.Bill
                retVal = "Bill"
            Case Else
                retVal = "Other"
        End Select
        Return retVal
    End Function 'enumeration function

    Public Function GetCaseActivities(ByVal ID As Integer, ByVal Status As Boolean, ByVal StartDate As Nullable(Of DateTime), ByVal CloseDate As Nullable(Of DateTime), Optional ByVal Search As String = "") As SqlDataReader
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ID", ID)
        db.AddParameter("@Status", Status)
        If StartDate.HasValue Then
            db.AddParameter("@StartDate", StartDate)
            db.AddParameter("@CloseDate", CloseDate)
        Else
            db.AddParameter("@StartDate", DBNull.Value)
            db.AddParameter("@CloseDate", DBNull.Value)
        End If
        If Search <> "" Then
            db.AddParameter("@Search", Search)
        Else
            db.AddParameter("@Search", DBNull.Value)
        End If
        Return CType(db.ExecuteReader("Legal_GetCaseActivities"), SqlDataReader)
    End Function

    Public Function AddLegalActivity() As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@AID", SqlDbType.Int, 4, ParameterDirection.Output, _AID)
        db.AddParameter("@NID", SqlDbType.Int, 4, ParameterDirection.Output, _NID)
        db.AddParameter("@CaseID", _CID)
        db.AddParameter("@Type", _NType)
        db.AddParameter("@Note", _Note)
        db.AddParameter("@ActivityState", _ActivitySate)
        db.AddParameter("@Status", _AStatus)
        db.AddParameter("@Subject", _Subject)
        db.AddParameter("@UserId", _AdminID)
        db.AddParameter("@TimeSpent", _TimeSpent)
        If _CloseDate.HasValue Then
            db.AddParameter("@CloseDate", _CloseDate)
        Else
            db.AddParameter("@CloseDate", DBNull.Value)
        End If
        db.AddParameter("@ActivityAssignedTo", _ActivityAssignedTo)
        If _AssignedTo.HasValue Then
            If _AssignedTo.Value > 0 Then
                db.AddParameter("@Assigned", _AssignedTo)
            Else
                db.AddParameter("@Assigned", DBNull.Value)
            End If
        End If
        db.ExecuteNonQuery("Legal_AddCaseActivity")
        Dim retNID As Integer
        retNID = CInt(CType(db.Parameters("@NID"), System.Data.SqlClient.SqlParameter).Value)
        Dim retAID As Integer
        retAID = CInt(CType(db.Parameters("@AID"), System.Data.SqlClient.SqlParameter).Value)
        If File1.FileName <> "" Then
            SaveAttachment(File1, retAID, retNID)
        End If
        If File2.FileName <> "" Then
            SaveAttachment(File2, retAID, retNID)
        End If
        If File3.FileName <> "" Then
            SaveAttachment(File3, retAID, retNID)
        End If
        Me.UpdateCaseTime()
        Return retAID

    End Function

    Public Function AddCaseNote() As Integer
        Dim db As DBAccess = New DBAccess()

        db.AddParameter("@ID", SqlDbType.Int, 4, ParameterDirection.Output, 0)
        db.AddParameter("@CaseID", _AID)
        db.AddParameter("@NType", _NType)
        db.AddParameter("@Notes", _Note)
        db.AddParameter("@UserId", _AdminID)

        If _ActivityAssignedTo > 0 Then
            db.AddParameter("@AssignedTo", _ActivityAssignedTo)
        Else
            db.AddParameter("@AssignedTo", DBNull.Value)
        End If
        If _TimeSpent <> "" Then
            db.AddParameter("@TimeSpent", _TimeSpent.ToString())
        Else
            db.AddParameter("@TimeSpent", DBNull.Value)
        End If
        If _Reminder Then
            db.AddParameter("@Reminder", _Reminder)
            db.AddParameter("@ReminderTime", _ReminderTime)
        Else
            db.AddParameter("@Reminder", DBNull.Value)
            db.AddParameter("@ReminderTime", DBNull.Value)
        End If
        If _Cost > 0 Then
            db.AddParameter("@Cost", Double.Parse(_Cost))

        Else
            db.AddParameter("@Cost", Double.Parse(Decimal.Zero))

        End If
        db.ExecuteNonQuery("Legal_AddCaseNote")
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
        Dim Path As String = ConfigurationManager.AppSettings("CaseAttachPath") & FolderId

        System.IO.Directory.CreateDirectory(HttpContext.Current.Server.MapPath(Path))
        file.SaveAs(HttpContext.Current.Server.MapPath(Path & "/") & Functions.MakeFileNameValid(file.FileName))
        Return CInt(Me.AddAttachment(ActivityID, NoteID, FolderId, file))
    End Function

    Public Function AddAttachment(ByVal ActivityID As Integer, ByVal NoteID As Integer, ByVal FolderId As String, ByRef File As FileUpload) As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ActivityID", ActivityID)
        db.AddParameter("@FilePath", FolderId & "\" & Functions.MakeFileNameValid(File.FileName))
        db.AddParameter("@NoteID", NoteID)
        Return CInt(db.ExecuteNonQuery("Legal_ActivityNoteAttachments"))
    End Function

    Public Function GetSingleActivity(ByVal ID As Integer)
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ID", ID)
        Return CType(db.ExecuteReader("LegaL_GetSingleCaseActivity"), SqlDataReader)
    End Function

    Public Function GetNotesByActivtyID(ByVal ActivityID As Integer) As DataSet
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ActivityID", ActivityID)
        Dim ds As DataSet = db.ExecuteDataSet("Legal_GetNotesByActivtyID")
        ds.Tables(0).TableName = "Activities"
        ds.Tables(1).TableName = "Attachments"
        ds.Relations.Add("NOTE_ATTACH", ds.Tables("Activities").Columns("ID"), ds.Tables("Attachments").Columns("NoteID"))
        Return ds
    End Function
    Public Function UpdateCaseStatus() As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ActivityState", _ActivitySate)
        db.AddParameter("@ActivityID", _AID)
        If _WaitingFor.HasValue Then
            If _WaitingFor.Value > 0 Then
                db.AddParameter("@WaitingFor", _WaitingFor)
            Else
                db.AddParameter("@WaitingFor", DBNull.Value)
            End If
        End If
        Return db.ExecuteNonQuery("Legal_UpdateCaseStatus")
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
                dr.Close()
            Else
                dr.Close()
                Return "NONE"
            End If
        Else
            Return "NONE"
        End If
    End Function
    Public Shared Function GetTimeSpent(ByVal time As String) As String
        If time <> "" Then
            Dim ntime As String() = time.Split(":")
            Return ntime(0) & ":" & ntime(1)
        Else
            Return "00:00"
        End If
    End Function
    Public Function SearchFranchisee(ByVal Key As String) As SqlDataReader
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@Key", Key)
        Return CType(db.ExecuteReader("Legal_SearchFranchisee"), SqlDataReader)
    End Function
    Public Shared Function GetAttachmentFileName(ByVal FilePath As String) As String
        Dim file As String()
        file = FilePath.Split("\")
        Return file(1)
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
    Public Shared Function GetGridTimeSpent(ByVal time As String) As String
        If time <> "" Then
            Dim ntime As String() = time.Split(":")
            Return ntime(0) & ":" & ntime(1)
        Else
            Return "00:00"
        End If
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
    Public Sub UpdateCase()
        Dim db As New DBAccess

        db.AddParameter("ID", _CID)
        db.AddParameter("@Title", _Title)
        If _Franchisee > 0 Then
            db.AddParameter("@Franchisee", _Franchisee)
        Else
            db.AddParameter("@Franchisee", DBNull.Value)
        End If
        db.AddParameter("@Type", _Type)
        db.AddParameter("@AssignedTo", _AssignedTo)
        If _DateEntered.HasValue Then
            db.AddParameter("@DateEntered", _DateEntered)
        Else
            db.AddParameter("@DateEntered", DBNull.Value)
        End If
        db.AddParameter("@FirmID", _Firm)
        If _ContactID > 0 AndAlso _ContactID.ToString() <> "" Then
            db.AddParameter("@ContactID", _ContactID)
        Else
            db.AddParameter("@ContactID", 0)
        End If

        If _ConcernedParties.ToString() <> "" Then
            db.AddParameter("@ConcernedParties", _ConcernedParties)
        Else
            db.AddParameter("@ConcernedParties", DBNull.Value)
        End If
        If _Note.Length < 1 Then
            db.AddParameter("@Description", DBNull.Value)
        Else
            db.AddParameter("@Description", _Note)
        End If
        db.AddParameter("@Status", _Status)
        If _FirmCaseNo.Length < 1 Then
            db.AddParameter("@FirmCaseNo", DBNull.Value)
        Else
            db.AddParameter("@FirmCaseNo", _FirmCaseNo)
        End If
        If _DocketNo.Length < 1 Then
            db.AddParameter("@DocketNo", DBNull.Value)
        Else
            db.AddParameter("@DocketNo", _DocketNo)
        End If
        db.AddParameter("@CaseDate", _CaseDate)
        db.AddParameter("@UserID", _AdminID)
        db.ExecuteNonQuery("Legal_UpdateCase")
        db.Dispose()
    End Sub
    Public Function DeleteCase(ByVal ID As Integer) As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ID", ID)
        db.AddParameter("@ModuleID", 1)
        Return (CInt(db.ExecuteNonQuery("Legal_DeleteCase")))

    End Function
    Public Function GetCaseFirmInfo(ByVal CaseID As Integer) As SqlDataReader
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("ID", CaseID)
        Return CType(db.ExecuteReader("Legal_GetCaseFirmInfo"), SqlDataReader)
    End Function
    Public Sub UpdateCaseTime()
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@CaseID", _CID)
        db.ExecuteNonQuery("Legal_UpdateCaseTime")
    End Sub
    Public Sub UpdateActivityCost(ByVal ActivityID As Integer, ByVal Cost As Decimal)
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ActivityID", ActivityID)
        db.AddParameter("@Cost", Cost)
        db.ExecuteNonQuery("Legal_UpdateActivityCost")
    End Sub
    Public Sub UpdateCaseCost(ByVal CaseID As Integer)
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@CaseID", CaseID)
        db.ExecuteNonQuery("Legal_UpdateCaseCost")
    End Sub
    Public Sub AddActivityReminder()
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ModuleID", 1)
        db.AddParameter("@ActivityID", _AID)
        db.AddParameter("@UserId", _AdminID)
        db.AddParameter("@ReminderTime", _ReminderTime)
        db.ExecuteNonQuery("Legal_AddNewReminder")
    End Sub
    Public Function GetCaseTypes() As SqlDataReader
        Return New DBAccess().ExecuteReader("Legal_GetCaseTypes")
    End Function
    Public Function GetCaseStatusTypes() As SqlDataReader
        Return New DBAccess().ExecuteReader("Legal_GetCaseStatusTypes")
    End Function
    Public Function UpdateCaseTypes(ByVal ID As Integer, ByVal Name As String) As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ID", ID)
        db.AddParameter("@Name", Name)
        db.AddParameter("@Validate", SqlDbType.Int, 4, ParameterDirection.Output, 0)
        db.ExecuteNonQuery("Legal_UpdateCaseType")
        Return CInt(CType(db.Parameters("@Validate"), System.Data.SqlClient.SqlParameter).Value)
    End Function
    Public Function UpdateCaseStatusTypes(ByVal ID As Integer, ByVal Name As String) As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ID", ID)
        db.AddParameter("@Name", Name)
        db.AddParameter("@Validate", SqlDbType.Int, 4, ParameterDirection.Output, 0)
        db.ExecuteNonQuery("Legal_UpdateCaseStatusType")
        Return CInt(CType(db.Parameters("@Validate"), System.Data.SqlClient.SqlParameter).Value)
    End Function
    Public Sub DeleteCaseType(ByVal ID As Integer)
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ID", ID)
        db.ExecuteNonQuery("Legal_DeleteCaseType")
    End Sub
    Public Sub DeleteCaseStatusType(ByVal ID As Integer)
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ID", ID)
        db.ExecuteNonQuery("Legal_DeleteCaseStatusType")
    End Sub
    Public Shared Function AddNewCaseType(ByVal Name As String) As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@Name", Name)
        db.AddParameter("@Value", SqlDbType.Int, 4, ParameterDirection.Output, 0)
        db.ExecuteNonQuery("Legal_AddCaseType")
        Return CInt(CType(db.Parameters("@Value"), System.Data.SqlClient.SqlParameter).Value)
    End Function
    Public Shared Function AddNewCaseStatusType(ByVal Name As String) As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@Name", Name)
        db.AddParameter("@Value", SqlDbType.Int, 4, ParameterDirection.Output, 0)
        db.ExecuteNonQuery("Legal_AddCaseStatusType")
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
        db.AddParameter("@ModuleID", 3)
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
    Public Function GetCaseActivityTypes() As SqlDataReader
        Return New DBAccess().ExecuteReader("Legal_GetCaseActivityType")
    End Function
    Public Function UpdateCaseActivityType(ByVal ID As Integer, ByVal Name As String) As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ID", ID)
        db.AddParameter("@Name", Name)
        db.AddParameter("@Validate", SqlDbType.Int, 4, ParameterDirection.Output, 0)
        db.ExecuteNonQuery("Legal_UpdateCaseActivityType")
        Return CInt(CType(db.Parameters("@Validate"), System.Data.SqlClient.SqlParameter).Value)
    End Function
    Public Sub DeleteCaseActivityType(ByVal ID As Integer)
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ID", ID)
        db.ExecuteNonQuery("Legal_DeleteCaseActivityType")
    End Sub
    Public Shared Function AddNewCaseActivityType(ByVal Name As String) As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@Name", Name)
        db.AddParameter("@Value", SqlDbType.Int, 4, ParameterDirection.Output, 0)
        db.ExecuteNonQuery("Legal_AddCaseActivityType")
        Return CInt(CType(db.Parameters("@Value"), System.Data.SqlClient.SqlParameter).Value)
    End Function
    Public Function UpdateLastModified() As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@CaseID", Me.CID)
        db.ExecuteNonQuery("Legal_UpdateCase_LastModified")
    End Function
    Public Sub AlertActions()
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ID", Me.NID)
        db.AddParameter("@Type", Me.Type)
        db.ExecuteNonQuery("Legal_UpdateAlerts")
    End Sub
    Public Function GetAll_Cases_IP_History(ByVal RequestFrom As Integer, ByVal ID As Integer, ByVal StartDate As DateTime, ByVal EndDate As DateTime, ByVal Type As Integer, ByVal Search As String, ByVal SortExpression As String, ByVal startRowIndex As Integer, ByVal MaximumRows As Integer) As SqlDataReader
        Dim db As DBAccess = New DBAccess()
        If Type <> -1 Then
            db.AddParameter("@Type", Type)
        End If
        If String.IsNullOrEmpty(Search) = False Then
            db.AddParameter("@Search", Search)
        End If
        db.AddParameter("@RequestFrom", RequestFrom)
        db.AddParameter("@ID", ID)
        db.AddParameter("@StartDate", StartDate)
        db.AddParameter("@EndDate", EndDate)
        db.AddParameter("@SortExpression", SortExpression)
        db.AddParameter("@startRowIndex", startRowIndex)
        db.AddParameter("@maximumRows", MaximumRows)
        Return db.ExecuteReader("Legal_GetAll_Cases_IP_History")
    End Function

    Public Function GetAllCount_Cases_IP_History(ByVal RequestFrom As Integer, ByVal ID As Integer, ByVal StartDate As DateTime, ByVal EndDate As DateTime, ByVal Type As Integer, ByVal Search As String) As Integer
        Dim db As DBAccess = New DBAccess()
        If Type <> -1 Then
            db.AddParameter("@Type", Type)
        End If
        If String.IsNullOrEmpty(Search) = False Then
            db.AddParameter("@Search", Search)
        End If
        db.AddParameter("@RequestFrom", RequestFrom)
        db.AddParameter("@ID", ID)
        db.AddParameter("@StartDate", StartDate)
        db.AddParameter("@EndDate", EndDate)
        Return CType(db.ExecuteScalar("Legal_GetAllCount_Cases_IP_History"), Integer)
    End Function
    
End Class
